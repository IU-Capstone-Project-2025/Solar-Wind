import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'package:http_parser/http_parser.dart';


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

    // 📷 Читаем изображение как байты
    final bytes = await photo.readAsBytes();

    // 🖼️ Декодируем изображение
    final originalImage = img.decodeImage(bytes);
    if (originalImage == null) {
      throw Exception('Failed to decode image');
    }

    // 🔧 Сжимаем и конвертируем в JPEG (80% качества)
    final jpgBytes = img.encodeJpg(originalImage, quality: 80);

    // 💾 Сохраняем временный файл JPEG
    final tempDir = Directory.systemTemp;
    final compressedFile = File('${tempDir.path}/compressed_photo.jpg');
    await compressedFile.writeAsBytes(jpgBytes);

    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(
        compressedFile.path,
        filename: 'photo.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
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
