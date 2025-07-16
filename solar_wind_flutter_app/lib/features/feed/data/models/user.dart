import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String cityName;

  @HiveField(4)
  final List<int> preferredGymTime;

  @HiveField(5)
  final List<String> sportName;

  User({
    required this.id,
    required this.username,
    required this.description,
    required this.cityName,
    required this.preferredGymTime,
    required this.sportName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      description: json['description'],
      cityName: json['cityName'],
      preferredGymTime: List<int>.from(json['preferredGymTime'] ?? []),
      sportName: List<String>.from(json['sportName'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'description': description,
        'cityName': cityName,
        'preferredGymTime': preferredGymTime,
        'sportName': sportName,
      };
}
