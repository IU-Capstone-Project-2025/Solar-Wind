import json
from datetime import date
from os import getenv

import psycopg2


def calculate_age(birth_date: date) -> int:
    today = date.today()
    return today.year - birth_date.year - ((today.month, today.day) < (birth_date.month, birth_date.day))

def prepare_user(row) -> dict[str: any]:
    return {
        "id": row["id"],
        "age": calculate_age(row["age"]),
        "gender": 0 if row["gender"]=="MALE" else 1,
        "preferredGender": 0 if row["preferred_gender"]=="MALE" else 1,
        "preferredGymTime": json.loads(row["preferred_gym_time"]) if row["preferred_gym_time"].startswith("[") else [int(row["preferred_gym_time"])],
        "sports_ids": row["sports_ids"]
    }


pg_conn = psycopg2.connect(
    host=getenv("POSTGRES_HOST"),
    port=5432,
    dbname=getenv("POSTGRES_DB"),
    user=getenv("POSTGRES_USER"),
    password=getenv("POSTGRES_PASSWORD")
)
pg_conn.autocommit = True
cursor = pg_conn.cursor()

def retrieve_users():
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