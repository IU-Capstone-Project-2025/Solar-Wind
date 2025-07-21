import 'package:dio/dio.dart';
import '../models/sport.dart';

class SportService {
  final Dio dio;

  SportService({Dio? dio}) : dio = dio ?? Dio();

  Future<List<Sport>> searchSports(String query) async {
    final response = await dio.get(
      'https://solar-wind-gymbro.ru/profiles/api/sports/search',
      queryParameters: {
        'word': query,
      },
    );

    final data = response.data as List;
    return data.map((json) => Sport.fromJson(json)).toList();
  }
}
