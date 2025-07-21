class Sport {
  final int id;
  final String name;

  Sport({required this.id, required this.name});

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        id: json['id'],
        name: json['sportType'] ?? '',
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sport && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
