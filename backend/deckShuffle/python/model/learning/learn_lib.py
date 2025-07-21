from torch import no_grad
from sklearn.metrics import accuracy_score, roc_auc_score

@no_grad()
def evaluate(model, dataloader):
    model.eval()
    preds = []
    labels = []

    for a, b, label in dataloader:
        out = model(a, b).squeeze()
        preds += out.tolist()
        labels += label.tolist()

    preds_bin = [int(p > 0.5) for p in preds]
    acc = accuracy_score(labels, preds_bin)
    auc = roc_auc_score(labels, preds)
    return acc, auc


def train(model, train_loader, val_loader, optimizer, criterion,
          max_epochs=50, patience=5, min_delta=1e-4):
    val_accuracies = []
    best_auc = 0
    epochs_no_improve = 0
    for epoch in range(max_epochs):
        model.train()
        total_loss = 0
        for a, b, label in train_loader:
            optimizer.zero_grad()
            out = model(a, b).squeeze()
            loss = criterion(out, label)
            loss.backward()
            optimizer.step()
            total_loss += loss.item()
        acc, auc = evaluate(model, val_loader)
        val_accuracies.append(acc)
        if auc - best_auc > min_delta:
            best_auc = auc
            epochs_no_improve = 0
        else:
            epochs_no_improve += 1
        if epochs_no_improve >= patience: break
    return val_accuracies

