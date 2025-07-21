import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoPostService {
  final Dio dio;

  PhotoPostService({Dio? dio}) : dio = dio ?? Dio();

  Future<void> sendPhoto(File photo) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final telegramId = prefs.getString('telegram_id');

    if (token == null || telegramId == null) {
      throw Exception('Missing token or telegram_id in SharedPreferences');
    }

    final fileName = photo.path.split('/').last;

    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(photo.path, filename: fileName),
    });

    final response = await dio.post(
      'https://solar-wind-gymbro.ru/profiles/api/photo/save',
      data: formData,
      options: Options(
        headers: {
          'Authorize': token,
          'Authorization-telegram-id': telegramId,
        },
        contentType: 'multipart/form-data',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send photo. Status: ${response.statusCode}');
    }
  }
}
