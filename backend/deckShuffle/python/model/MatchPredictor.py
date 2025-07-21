import torch
from torch import nn

from model.UserEncoder import UserEncoder


class MatchPredictor(nn.Module):
    def __init__(self):
        super().__init__()
        self.encoder = UserEncoder()
        inner = 150
        self.predictor = nn.Sequential(
            nn.Linear(64, inner),
            nn.ReLU(),
            nn.BatchNorm1d(inner),
            nn.Linear(inner, 1),
            nn.Sigmoid()
        )

    def forward(self, user_a_input, user_b_input):
        ua = self.encoder(*user_a_input)
        ub = self.encoder(*user_b_input)
        combined = torch.cat([ua, ub], dim=1)
        return self.predictor(combined)
