from pathlib import Path

datasets_path = Path(__file__).resolve().parent / "learning" /"datasets"
model_path = datasets_path / "model.pt"
optimizer_path = datasets_path / "optimizer.pt"