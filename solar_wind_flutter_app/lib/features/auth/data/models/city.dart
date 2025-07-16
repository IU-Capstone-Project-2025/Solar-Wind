class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null || json['cityName'] == null) {
      throw FormatException('Invalid city data: $json');
    }

    return City(
      id: json['id'],
      name: json['cityName'],
    );
  }
}
