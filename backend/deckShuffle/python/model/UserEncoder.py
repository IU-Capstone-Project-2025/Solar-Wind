from pathlib import Path

import torch
from torch import nn

class UserEncoder(nn.Module):
    def __init__(self, num_sports=51, sport_emb_dim=10, gender_emb_dim=4, gym_time_emb_dim=4):
        super().__init__()
        self.sport_embedding = nn.Embedding(num_sports + 1, sport_emb_dim, 0)
        self.gender_embedding = nn.Embedding(2, gender_emb_dim)
        self.gym_time_embedding = nn.Embedding(7 + 1, gym_time_emb_dim, 0)
        input_dim = sport_emb_dim + gender_emb_dim * 2 + gym_time_emb_dim + 1
        hidden_dim = 64
        self.encoder = nn.Sequential(
            nn.Linear(input_dim, hidden_dim),
            nn.ReLU(),
            nn.Linear(hidden_dim, 32)
        )

    def forward(self, sports_ids, age, gender, preferred_gender, gym_days):
        # Necessary scaling, that hardcoded because of dataset in form of infinite datastream.
        # Values are chosen by target users.
        # (assumption, that average user is 19 y.o. and 71% of users are in [15, 30] regions)
        age = ((age - 19) / 6.5)
        # Scaling is not necessary, because of embedding used, which produce already normalized data
        sports_emb = self.sport_embedding(sports_ids)
        sports_vec = sports_emb.mean(dim=1)
        gym_time_emb = self.gym_time_embedding(gym_days)
        gym_time_vec = gym_time_emb.mean(dim=1)
        gender_vec = self.gender_embedding(gender.squeeze(1))
        pref_gender_vec = self.gender_embedding(preferred_gender.squeeze(1))
        x = torch.cat([sports_vec, gender_vec, pref_gender_vec, gym_time_vec, age], dim=1)
        return self.encoder(x)
