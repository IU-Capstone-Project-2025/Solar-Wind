import json
from torch.utils.data import Dataset
from torch import tensor, stack, float32

class MatchDataset(Dataset):
    def __init__(self, pairs_file, profile_file):
        with open(pairs_file) as f:
            self.pairs = json.load(f)
        with open(profile_file) as f:
            self.profiles = {
                int(p["id"]): padded_user(p) for p in json.load(f)
            }

    def __getitem__(self, idx):
        pair = self.pairs[idx]
        a = self.profiles[pair["user_a_id"]]
        b = self.profiles[pair["user_b_id"]]
        label = float(pair["liked"])

        return encode(a), encode(b), label

    def __len__(self):
        return len(self.pairs)


def encode(user):
    sports = tensor(user["sports_ids"])
    age = tensor([user["age"]] if user["age"] else [0])
    gender = tensor([user["gender"]])
    pref_gender = tensor([user["preferredGender"]])
    gym_days = tensor(user["preferredGymTime"] if user["preferredGymTime"] else [0])

    return sports, age, gender, pref_gender, gym_days


def padded_user(user: dict[str: any]):
    def padded(arr: list[int], limit, pad=0):
        return arr + [pad] * (limit - n) if (n:=len(arr)) < limit else arr[:limit]

    user = user.copy()
    user["sports_ids"] = padded(user["sports_ids"], 15)
    user["preferredGymTime"] = padded(user["preferredGymTime"], 7)
    return user


def match_collate_fn(batch):
    a_list, b_list, labels = zip(*batch)  # распакуем
    def stack_fields(user_list):
        sports = stack([u[0] for u in user_list])
        age = stack([u[1] for u in user_list])
        gender = stack([u[2] for u in user_list])
        pref_gender = stack([u[3] for u in user_list])
        gym_days = stack([u[4] for u in user_list])
        return sports, age, gender, pref_gender, gym_days

    a_batch = stack_fields(a_list)
    b_batch = stack_fields(b_list)
    labels = tensor(labels, dtype=float32)
    return a_batch, b_batch, labels
