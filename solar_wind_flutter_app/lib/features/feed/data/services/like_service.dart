import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeService {
  final Dio dio;

  LikeService({Dio? dio}) : dio = dio ?? Dio();

  Future<void> likeUser(int user2) async {
    final prefs = await SharedPreferences.getInstance();
    final telegramId = prefs.getString('telegram_id');
    final token = prefs.getString('token');

    if (telegramId == null || token == null) {
      throw Exception('Missing token or telegram_id in SharedPreferences');
    }

    print('Telegram ID: $telegramId');
    print('Token: $token');
    print('Receiver ID: $user2');

    try {
      final response = await dio.post(
        'https://solar-wind-gymbro.ru/likes/',
        queryParameters: {
          'receiver': user2.toString(),
        },
        options: Options(
          headers: {
            'Authorization-telegram-id': telegramId,
            'Authorize': token,
          },
        ),
      );

      print('Like successful: ${response.statusCode}');
    } catch (e) {
      print('Error liking user: $e');
      rethrow;
    }
  }
}