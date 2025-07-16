import 'package:dio/dio.dart';
import '../models/city.dart';

class CityService {
  final Dio dio;

  CityService({Dio? dio}) : dio = dio ?? Dio();

  Future<List<City>> searchCities(String query) async {
    final response = await dio.get(
      'https://solar-wind-gymbro.ru/profiles/api/cities/search',
      queryParameters: {
        'word': query,
      },
    );

    final data = response.data as List;
    print(data);
    return data.map((json) => City.fromJson(json)).toList();
  }
}
