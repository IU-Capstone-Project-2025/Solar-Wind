import 'package:dio/dio.dart';
import '../models/auth.dart';

class AuthService {
  final Dio dio;

  AuthService({Dio? dio}) : dio = dio ?? Dio();

  Future<Auth> sendCode(String code) async {
    final response = await dio.get(
      'https://solar-wind-gymbro.ru/profiles/auth/telegram/custom-auth',
      queryParameters: {'code': code},
    );
    return Auth.fromJson(response.data);
  }
}
