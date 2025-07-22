import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

class PhotoGetService {
  final Dio dio;

  PhotoGetService({Dio? dio}) : dio = dio ?? Dio();

  Future<Uint8List> getPhoto(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final telegramId = prefs.getString('telegram_id');

    if (token == null || telegramId == null) {
      throw Exception('Missing token or telegram_id in SharedPreferences');
    }

    final response = await dio.post(
      'https://solar-wind-gymbro.ru/profiles/api/photo/get',
      data: {'id': id},
      options: Options(
        headers: {
          'Authorize': token,
          'Authorization-telegram-id': telegramId,
        },
        responseType: ResponseType.bytes, // Важно для получения байтов
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get photo. Status: ${response.statusCode}');
    }

    return Uint8List.fromList(response.data);
  }
}

