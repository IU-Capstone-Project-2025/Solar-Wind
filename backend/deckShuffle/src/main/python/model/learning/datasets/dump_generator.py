import json
import random
import numpy as np
from typing import List, Dict

random.seed(42)
np.random.seed(42)

NUM_USERS = 500
NUM_LIKES = 2000
SPORT_GROUP_SIZES = [2, 5, 3, 5, 5, 4, 13, 4, 6, 2, 1]
SPORT_GROUP_INDICES = []
start = 1
for size in SPORT_GROUP_SIZES:
    SPORT_GROUP_INDICES.append(list(range(start, start + size)))
    start += size
TOTAL_SPORTS = sum(SPORT_GROUP_SIZES)

# GENDERS = ["MALE", "FEMALE"]
GENDERS = [0, 1]
DAYS_OF_WEEK = [1, 2, 3, 4, 5, 6, 7]


def sample_age():
    while True:
        age = int(np.random.normal(loc=19, scale=6))
        if age >= 15:
            return age


def sample_preferred_days():
    base = random.choice([[2, 4, 6], [1, 3, 5]])
    extra = [d for d in DAYS_OF_WEEK if d not in base and random.random() < 0.3]
    subset = sorted(list(set(base + extra)))
    if random.random() < 0.1:
        subset = random.sample(subset, k=max(1, len(subset) - 1))
    return subset


def sample_sports():
    sports = set()

    # Common sports (0-19)
    for i in range(1, 21):
        if random.random() < 0.15:
            sports.add(i)

    # Rare sports (20-23)
    for i in range(21, 25):
        if random.random() < 0.05:
            sports.add(i)

    # Conflicting groups (24+)
    for group in SPORT_GROUP_INDICES:
        for i, sport in enumerate(group):
            prob = 0.07 / (i + 1)
            if random.random() < prob:
                sports.add(sport)

    return sorted(list(sports))[:random.randint(1, 5)]


def generate_users(n: int) -> List[Dict]:
    users = []
    for user_id in range(1, n + 1):
        gender = random.choice(GENDERS)
        preferred_gender = random.choice(GENDERS)
        user = {
            "id": user_id,
            "age": sample_age(),
            "gender": gender,
            "preferredGender": preferred_gender,
            "preferredGymTime": sample_preferred_days(),
            "sports_ids": sample_sports(),
        }
        users.append(user)
    return users


def sport_group(sport_id):
    for idx, group in enumerate(SPORT_GROUP_INDICES):
        if sport_id in group:
            return idx
    return -1


def compute_like_probability(user_a, user_b):
    score = 0.0

    # Strong effect: gender preference match
    if user_a["preferredGender"] == user_b["gender"]:
        score += 2.0

    # Age closeness
    age_diff = abs(user_a["age"] - user_b["age"])
    score += max(0, 1.5 - 0.2 * age_diff)  # decreases with distance

    # Matching gym days
    common_days = len(set(user_a["preferredGymTime"]) & set(user_b["preferredGymTime"]))
    score += 0.3 * common_days

    # Matching sports
    common_sports = set(user_a["sports_ids"]) & set(user_b["sports_ids"])
    score += 0.5 * len(common_sports)

    # Weak: same sport group
    groups_a = {sport_group(s) for s in user_a["sports_ids"]}
    groups_b = {sport_group(s) for s in user_b["sports_ids"]}
    score += 0.05 * len(groups_a & groups_b)

    # Convert score to probability via sigmoid
    prob = 1 / (1 + np.exp(-score + 3.5))
    return prob


def generate_likes(users: List[Dict], num_likes: int) -> List[Dict]:
    user_dict = {u["id"]: u for u in users}
    user_ids = list(user_dict.keys())
    likes = []

    attempts = 0
    while len(likes) < num_likes and attempts < num_likes * 10:
        a, b = random.sample(user_ids, 2)
        user_a = user_dict[a]
        user_b = user_dict[b]
        prob = compute_like_probability(user_a, user_b)
        liked = int(random.random() < prob)
        likes.append({"user_a_id": a, "user_b_id": b, "liked": liked})
        attempts += 1

    return likes


users_data = generate_users(NUM_USERS)
likes_data = generate_likes(users_data, NUM_LIKES)

with open("dump_users.json", "w") as f_users:
    json.dump(users_data, f_users, indent=2)

with open("dump_likes.json", "w") as f_likes:
    json.dump(likes_data, f_likes, indent=2)
