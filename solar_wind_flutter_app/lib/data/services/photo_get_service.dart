import 'package:dio/dio.dart';

class RegistrationService {
  final Dio dio;

  RegistrationService({Dio? dio}) : dio = dio ?? Dio();

  Future<void> getPhoto(RegistrationData data) async {
    final token = prefs.getString('token');
    final telegramId = prefs.getString('telegram_id');

    if (token == null || telegramId == null) {
      throw Exception('Missing token or telegram_id in SharedPreferences');
    }

    final response = await dio.post(
      'https://solar-wind-gymbro.ru/profiles/api/photo/get',
      data: ,
      options: Options(
        headers: {
          'Authorize': token,
          'Authorization-telegram-id': telegramId,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send photo. Status: ${response.statusCode}');
    }
  }
}