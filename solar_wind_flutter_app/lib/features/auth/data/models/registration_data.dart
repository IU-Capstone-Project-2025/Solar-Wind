import 'package:shared_preferences/shared_preferences.dart';

class RegistrationData {
  String? username;
  String? description;
  int? cityId;
  List<int> sportId = [];
  List<int> days = [1];
  String? gender; 
  String? preferredGender;
  DateTime? birthDate;

  Map<String, dynamic> toJson() => {
    "username": username,
    "firstName": "firstName",
    "lastName": "lastName",
    "description": description,
    "age": birthDate != null
        ? '${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}'
        : null,
    "gender": gender,
    "preferredGender": preferredGender,
    "cityId": cityId,
    "preferredGymTime": days,
    "sportId": sportId
  };

  Future<Map<String, dynamic>> toJsonWithPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final telegramId = prefs.getString('telegram_id');

    final base = toJson();
    base["telegramId"] = telegramId;
    base["id"] = telegramId;
    return base;
  }
}
