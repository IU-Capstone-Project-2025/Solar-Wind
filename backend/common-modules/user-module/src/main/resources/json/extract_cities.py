import json

def extract_city_names(input_path: str, output_path: str):
    """
    Читает JSON-файл со списком городов с подробными данными и сохраняет новый JSON
    только с массивом названий городов.
    """
    # Чтение исходного JSON
    with open(input_path, 'r', encoding='utf-8') as infile:
        cities = json.load(infile)

    # Извлечение имен городов
    city_names = [city.get('name') for city in cities if 'name' in city]

    # Сохранение нового JSON с названиями городов
    with open(output_path, 'w', encoding='utf-8') as outfile:
        json.dump(city_names, outfile, ensure_ascii=False, indent=2)

    print(f"Сохранено {len(city_names)} городов в файл: {output_path}")


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Извлекает названия городов из JSON и сохраняет их в отдельный файл.")
    parser.add_argument("input", help="Путь к входному JSON файлу (список городов)")
    parser.add_argument("output", help="Путь к выходному JSON файлу (только названия городов)")
    args = parser.parse_args()

    extract_city_names(args.input, args.output)
