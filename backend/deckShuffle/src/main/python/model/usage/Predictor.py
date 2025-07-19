from pathlib import Path

import torch

from model.MatchPredictor import MatchPredictor
from model.learning.MatchDataset import encode
from model.learning.learn_script import learn


class Predictor:
    def __init__(self, model_path: Path):
        self.model = MatchPredictor()
        if not model_path.exists():
            learn()
        self.model.load_state_dict(torch.load(model_path))
        self.model.eval()

    def predict(self, user_pair: dict) -> float:
        with torch.no_grad():
            user1_input = encode(user_pair["user1"])
            user2_input = encode(user_pair["user2"])
            score = self.model(user1_input, user2_input)
            return float(score.item())
