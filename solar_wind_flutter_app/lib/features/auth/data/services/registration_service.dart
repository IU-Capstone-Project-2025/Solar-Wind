import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/registration_data.dart';

class RegistrationService {
  final Dio dio;

  RegistrationService({Dio? dio}) : dio = dio ?? Dio();

  Future<void> register(RegistrationData data) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    final telegramId = prefs.getString('telegram_id');

    if (token == null || telegramId == null) {
      throw Exception('Missing token or telegram_id in SharedPreferences');
    }

    final response = await dio.post(
      'https://solar-wind-gymbro.ru/profiles/api/me',
      data: await data.toJsonWithPrefs(),
      options: Options(
        headers: {
          'Authorize': token,
          'Authorization-telegram-id': telegramId,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register. Status: ${response.statusCode}');
    }
  }
}


// import 'dart:async';
// import '../models/registration_data.dart';

// class RegistrationService {
//   Future<void> register(RegistrationData data) async {
//     print('Mock Registration Request:');
//     print(data.toJson());

//     await Future.delayed(const Duration(seconds: 1));

//     print('Mock Registration Success');
//   }
// }
