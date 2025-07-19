import torch

from model.MatchPredictor import MatchPredictor
from model.learning.MatchDataset import encode

class Predictor:
    def __init__(self, model_path: str):
        self.model = MatchPredictor()
        self.model.load_state_dict(torch.load(model_path))
        self.model.eval()

    def predict(self, user_pair: dict) -> float:
        with torch.no_grad():
            user1_input = encode(user_pair["user1"])
            user2_input = encode(user_pair["user2"])
            score = self.model(user1_input, user2_input)
            return float(score.item())
