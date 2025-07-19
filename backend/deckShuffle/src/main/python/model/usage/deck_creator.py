from itertools import groupby
from os import getenv

import psycopg2
import redis
import json
from datetime import date
from typing import List, Any
from model.paths import model_path

from model.usage.Predictor import Predictor

pg_conn = psycopg2.connect(
    host=getenv("POSTGRES_HOST"),
    port=5432,
    dbname=getenv("POSTGRES_DB"),
    user=getenv("POSTGRES_USER"),
    password=getenv("POSTGRES_PASSWORD")
)
pg_conn.autocommit = True
cursor = pg_conn.cursor()

r = redis.Redis(host=getenv("REDIS_HOST"), password=getenv("REDIS_PASSWORD"), port=6379, decode_responses=True)

def calculate_age(birth_date: date) -> int:
    today = date.today()
    return today.year - birth_date.year - ((today.month, today.day) < (birth_date.month, birth_date.day))

def prepare_user(row) -> dict[str: Any]:
    return {
        "id": row["id"],
        "age": calculate_age(row["age"]),
        "gender": 0 if row["gender"]=="MALE" else 1,
        "preferredGender": 0 if row["preferred_gender"]=="MALE" else 1,
        "preferredGymTime": json.loads(row["preferred_gym_time"]) if row["preferred_gym_time"].startswith("[") else [int(row["preferred_gym_time"])],
        "sports_ids": row["sports_ids"]
    }

model = Predictor(model_path)

cursor.execute("""
    SELECT u.id, u.age, u.gender, u.preferred_gender, 
           u.preferred_gym_time, u.city_id,
           COALESCE(json_agg(us.sport_id) FILTER (WHERE us.sport_id IS NOT NULL), '[]') as sports_ids
    FROM users u
    LEFT JOIN users_sports us ON u.id = us.user_id
    GROUP BY u.id
""")

columns = [desc[0] for desc in cursor.description]
users_raw = [dict(zip(columns, row)) for row in cursor.fetchall()]
users = [prepare_user(row) for row in users_raw]
grouped_users = [[*y] for (x, y) in groupby(users, key=lambda u: u["city_id"])]

for city in grouped_users:
    for user in city:
        scored: List[tuple[int, float]] = []
        for other in city:
            if user["id"] == other["id"]: continue
            score = model.predict({"user1": user, "user2": other})
            scored.append((other["id"], score))
        sorted_ids = [uid for uid, _ in sorted(scored, key=lambda x: x[1], reverse=True)]
        redis_key = f"user_deck:{user['id']}"
        r.delete(redis_key)
        if sorted_ids:
            r.rpush(redis_key, *sorted_ids)
