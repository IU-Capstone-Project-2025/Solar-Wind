import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/data/models/registration_data.dart';

class ProfileUpdateService {
  final Dio dio;

  ProfileUpdateService({Dio? dio}) : dio = dio ?? Dio();

  Future<void> updateProfile({
    required int userId,
    required RegistrationData data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final telegramId = prefs.getString('telegram_id');
    final token = prefs.getString('token');

    if (telegramId == null || token == null) {
      throw Exception('Missing token or telegram_id in SharedPreferences');
    }

    final payload = await data.toJsonWithPrefs();
    payload.addAll({
      "gender": "male",
      "preferredGender": "male",
      "age": "2025-07-16"
    });
    print(telegramId);
    print(token);
    print(payload);

    final response = await dio.put(
      'https://solar-wind-gymbro.ru/profiles/api/me',
      data: payload,
      options: Options(
        headers: {
          'Authorization-telegram-id': telegramId,
          'Authorize': token,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile. Status: ${response.statusCode}');
    }
  }
}

