import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class LikeNotificationService {
  final Dio dio;

  LikeNotificationService({Dio? dio}) : dio = dio ?? Dio();

  Future<List<User>> getLikedMeUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final telegramId = prefs.getString('telegram_id');
    final token = prefs.getString('token');

    if (telegramId == null || token == null) {
      throw Exception('Missing token or telegram_id in SharedPreferences');
    }

    try {
      final response = await dio.get(
        'https://solar-wind-gymbro.ru/notifications',
        options: Options(
          headers: {
            'Authorization-telegram-id': telegramId,
            'Authorize': token,
          },
        ),
      );

      print('Raw response data: ${response.data}');

      // Обработка пустого ответа
      if (response.statusCode == 204 || 
          response.data == null || 
          (response.data is List && response.data.isEmpty)) {
        return _fakeUsers();
      }

      // Обработка успешного ответа
      if (response.data is List) {
        final users = (response.data as List)
            .where((item) => item is Map) // Фильтруем только Map элементы
            .map<User>((json) => User.fromJson(json.cast<String, dynamic>()))
            .toList();

        if (users.isNotEmpty) {
          return users; // Возвращаем только реальных пользователей
        }
      }

      return _fakeUsers();
    } catch (e) {
      print('Error fetching liked users: $e');
      return _fakeUsers();
    }
  }

  List<User> _fakeUsers() {
    return [
      User(
        id: 1001,
        username: 'debug_alice',
        description: 'Test yogi 🧘‍♀️',
        cityName: 'Testburg',
        sportName: ['Yoga'],
        preferredGymTime: [7],
      ),
      User(
        id: 1002,
        username: 'qa_bob',
        description: 'Crossfit in test environment 💪',
        cityName: 'Mocktown',
        sportName: ['CrossFit'],
        preferredGymTime: [18],
      ),
    ];
  }
}

// import 'dart:async';
// import '../models/user.dart';

// class LikeNotificationService {
//   Future<List<User>> getLikedMeUsers() async {
//     await Future.delayed(const Duration(milliseconds: 300));

//     return [
//       User(
//         id: 1,
//         username: 'alice',
//         description: 'Loves yoga and morning runs',
//         cityName: 'Berlin',
//         sportName: ['Yoga', 'Running'],
//         preferredGymTime: [1],
//       ),
//       User(
//         id: 2,
//         username: 'bob',
//         description: 'Crossfit enthusiast',
//         cityName: 'Munich',
//         sportName: ['Crossfit'],
//         preferredGymTime: [1],
//       ),
//     ];
//   }
// }
