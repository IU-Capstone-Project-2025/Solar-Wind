import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';
import 'package:solar_wind_flutter_app/mock/mock_users.dart';

class FeedService {
  final Dio dio;

  FeedService({Dio? dio}) : dio = dio ?? Dio();

  Future<List<User>> fetchFeed() async {
    final prefs = await SharedPreferences.getInstance();
    final telegramId = prefs.getString('telegram_id');
    final token = prefs.getString('token');

    if (telegramId == null || token == null) {
      throw Exception('Missing token or telegram_id in SharedPreferences');
    }

    try {
      final response = await dio.get(
        'https://solar-wind-gymbro.ru/deckShuffle/api/create-deck',
        options: Options(headers: {
          'Authorization-telegram-id': telegramId,
          'Authorize': token,
        }),
      );

      print(response);
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data as List;
        final users = data.map((json) => User.fromJson(json)).toList();

        final enriched = [...users, ...mockUsers];

        final box = Hive.box('feedBox');
        await box.put('users', enriched);

        return enriched;
      } else {
        throw Exception('Failed to fetch feed. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch online. Using cached. Error: $e');
      final box = Hive.box('feedBox');
      final cachedUsers = box.get('users') as List<User>?;

      if (cachedUsers != null) return cachedUsers;
      throw Exception('No internet and no cached data available');
    }
  }
}



// import 'package:dio/dio.dart';
// import '../models/user.dart';

// class FeedService {
//   final Dio dio;

//   FeedService({Dio? dio}) : dio = dio ?? Dio();

//   Future<List<User>> fetchFeed() async {
//     await Future.delayed(const Duration(milliseconds: 500));

//     return [
//       User(
//         id: 1,
//         username: 'alex_fitness',
//         description: 'I love morning workouts 💪',
//         cityName: 'Berlin',
//         preferredGymTime: [9, 10],
//         sportName: ['Running', 'CrossFit'],
//       ),
//       User(
//         id: 2,
//         username: 'yoga_girl',
//         description: 'Namaste 🌿',
//         cityName: 'Munich',
//         preferredGymTime: [18],
//         sportName: ['Yoga', 'Pilates'],
//       ),
//       User(
//         id: 3,
//         username: 'night_lifter',
//         description: 'Deadlifts at midnight 🏋️‍♂️',
//         cityName: 'Hamburg',
//         preferredGymTime: [23],
//         sportName: ['Powerlifting'],
//       ),
//     ];
//   }
// }
