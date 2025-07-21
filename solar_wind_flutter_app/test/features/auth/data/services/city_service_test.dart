import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:solar_wind_flutter_app/features/auth/data/models/city.dart';
import 'package:solar_wind_flutter_app/features/auth/data/services/city_service.dart';

import 'city_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late CityService cityService;

  setUp(() {
    mockDio = MockDio();
    cityService = CityService(dio: mockDio);
  });

  test('searchCities returns list of City parsed from response', () async {
    final mockResponseData = [
      {'id': 1, 'name': 'Berlin'},
      {'id': 2, 'name': 'Munich'},
    ];

    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: mockResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

    final result = await cityService.searchCities('Ber');

    expect(result.length, 2);
    expect(result[0], isA<City>());
    expect(result[0].id, 1);
    expect(result[0].name, 'Berlin');
  });

  test('searchCities throws on non-200 response', () async {
    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenThrow(DioError(
      requestOptions: RequestOptions(path: ''),
      error: 'Network error',
      type: DioExceptionType.unknown,
    ));

    expect(() => cityService.searchCities('Berlin'), throwsA(isA<DioError>()));
  });
}
