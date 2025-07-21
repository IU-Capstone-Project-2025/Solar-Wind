import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:solar_wind_flutter_app/features/auth/data/models/sport.dart';
import 'package:solar_wind_flutter_app/features/auth/data/services/sport_service.dart';

import 'sport_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late SportService sportService;

  setUp(() {
    mockDio = MockDio();
    sportService = SportService(dio: mockDio);
  });

  test('searchSports returns list of Sport parsed from response', () async {
    final mockResponseData = [
      {'id': 1, 'sportType': 'Football'},
      {'id': 2, 'sportType': 'Tennis'},
    ];

    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

    final result = await sportService.searchSports('Foo');

    expect(result.length, 2);
    expect(result[0], isA<Sport>());
    expect(result[0].id, 1);
    expect(result[0].name, 'Football');
  });

  test('searchSports throws on DioException', () async {
    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      error: 'Network error',
      type: DioExceptionType.unknown,
    ));

    expect(() => sportService.searchSports('Tennis'), throwsA(isA<DioException>()));
  });

  test('searchSports throws on invalid response format', () async {
    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: {'invalid': 'data'},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

    expect(() => sportService.searchSports('Tennis'), throwsA(isA<TypeError>()));
  });
}
