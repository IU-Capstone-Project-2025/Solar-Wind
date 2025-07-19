import subprocess
import sys

from MatchDataset import MatchDataset, match_collate_fn
from model.MatchPredictor import MatchPredictor

from torch import nn, load, save
from torch.optim import Adam
from torch.utils.data import DataLoader
from torch.utils.data import random_split

from learn_lib import train
from model import paths

model = MatchPredictor()
optimizer = Adam(model.parameters(), lr=0.002)
criterion = nn.BCELoss()

likes_data_path = paths.datasets_path / "daily_likes.json"
users_data_path = paths.datasets_path / "user_profiles.json"

if paths.model_path.exists() and paths.optimizer_path.exists():
    model.load_state_dict(load(paths.model_path))
    optimizer.load_state_dict(load(paths.optimizer_path))
else:
    subprocess.run(
        [sys.executable, "dump_generator.py"],
        cwd=paths.datasets_path
    )
    likes_data_path, users_data_path =paths.datasets_path / "dump_likes.json", paths.datasets_path / "dump_users.json"

dataset = MatchDataset(likes_data_path, users_data_path)

val_ratio = 0.15
val_size = int(len(dataset) * val_ratio)
train_size = len(dataset) - val_size

train_ds, val_ds = random_split(dataset, [train_size, val_size])
train_loader = DataLoader(train_ds, batch_size=64, shuffle=True, collate_fn=match_collate_fn)
val_loader = DataLoader(val_ds, batch_size=64, collate_fn=match_collate_fn)

accs = train(model, train_loader, val_loader, optimizer, criterion)
save(model.state_dict(), paths.model_path)
save(optimizer.state_dict(), paths.optimizer_path)
with open(paths.datasets_path / "acc_logs", "a") as graph_data:
    graph_data.write(" ".join(map(str, accs)) + " ")