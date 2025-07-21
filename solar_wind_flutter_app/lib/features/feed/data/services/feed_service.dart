import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';
import 'package:solar_wind_flutter_app/mock/mock_users.dart';

class FeedService {
  final Dio dio;
  static const String _boxName = 'feedBox';

  FeedService({Dio? dio}) : dio = dio ?? Dio() {
    // Регистрируем адаптер, если еще не зарегистрирован
    if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
      Hive.registerAdapter(UserAdapter());
    }
  }

  Future<List<User>> fetchFeed() async {
    print('[FeedService] Starting feed fetch...');
    
    // 1. Получаем учетные данные
    final prefs = await SharedPreferences.getInstance();
    final telegramId = prefs.getString('telegram_id');
    final token = prefs.getString('token');

    if (telegramId == null || token == null) {
      print('❌ Missing credentials');
      throw Exception('Missing token or telegram_id in SharedPreferences');
    }

    try {
      // 2. Запрос к API
      print('🌐 Fetching feed from API...');
      final response = await dio.get<List<dynamic>>(
        'https://solar-wind-gymbro.ru/deckShuffle/api/create-deck',
        options: Options(headers: {
          'Authorization-telegram-id': telegramId,
          'Authorize': token,
        }),
      );

      print('✅ API response: ${response.statusCode}');
      print('📦 Data type: ${response.data?.runtimeType}');

      if (response.statusCode == 200 && response.data != null) {
        // 3. Парсинг пользователей
        final users = response.data!
            .map((json) => User.fromJson(json as Map<String, dynamic>))
            .toList();

        print('👥 Fetched ${users.length} real users');

        // 4. Обогащаем mock-пользователями
        final enriched = [...users, ...mockUsers];
        print('🎭 Added ${mockUsers.length} mock users');

        // 5. Сохраняем в Hive
        final box = await Hive.openBox<List<dynamic>>(_boxName);
        await box.put('users', enriched.map((u) => u.toJson()).toList());
        print('💾 Saved ${enriched.length} users to Hive');

        return enriched;
      } else {
        throw Exception('API returned ${response.statusCode}');
      }
    } catch (e) {
      print('⚠️ Error fetching feed: $e');
      print('🔄 Trying to load from cache...');
      
      try {
        // 6. Загрузка из кэша
        final box = await Hive.openBox<List<dynamic>>(_boxName);
        final cachedData = box.get('users');

        if (cachedData != null && cachedData is List) {
          final cachedUsers = cachedData
              .map((json) => User.fromJson(json as Map<String, dynamic>))
              .toList();
          
          print('♻️ Loaded ${cachedUsers.length} users from cache');
          return cachedUsers;
        }
      } catch (cacheError) {
        print('❌ Cache error: $cacheError');
      }

      print('🆘 No cache available, returning mock users');
      return mockUsers; // Fallback
    }
  }
}