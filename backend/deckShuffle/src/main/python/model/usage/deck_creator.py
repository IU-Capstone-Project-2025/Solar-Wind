from itertools import groupby
from os import getenv

import redis
from typing import List
from argparse import ArgumentParser

from model.datasources.users_db import retrieve_users
from model.paths import model_path

from model.usage.Predictor import Predictor

parser = ArgumentParser()
parser.add_argument("-i", "--id", help="path to model", default=None)
args = parser.parse_args()
def no_filter(it):
    return iter(it)
def one_item_filter(it, id_):
    return filter(lambda x: x["id"] == id_, it)
filter_ = lambda it: one_item_filter(it, int(parser.id)) if parser.id is not None else no_filter(it)

r = redis.Redis(host=getenv("REDIS_HOST"), password=getenv("REDIS_PASSWORD"), port=6379, decode_responses=True)
model = Predictor(model_path)
grouped_users = [[*y] for (x, y) in groupby(retrieve_users(), key=lambda u: u["city_id"])]

for city in grouped_users:
    for user in filter_(city):
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
