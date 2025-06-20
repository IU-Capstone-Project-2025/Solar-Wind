import requests
from bs4 import BeautifulSoup
import json

def fetch_sports_list():
    url = "https://ru.wikipedia.org/wiki/Категория:Виды_спорта_по_алфавиту"
    resp = requests.get(url)
    resp.raise_for_status()
    soup = BeautifulSoup(resp.text, "html.parser")

    container = soup.find("div", id="mw-pages")
    items = container.find_all("li")

    sports = [li.get_text(strip=True) for li in items]
    return sports

if __name__ == "__main__":
    sports = fetch_sports_list()
    with open("sports.json", "w", encoding="utf-8") as f:
        json.dump(sports, f, ensure_ascii=False, indent=2)
    print(f"Сохранено {len(sports)} видов спорта в sports_alphabet.json")