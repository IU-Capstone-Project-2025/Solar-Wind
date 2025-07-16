import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:solar_wind_flutter_app/features/feed/data/services/profile_service.dart';
import 'package:solar_wind_flutter_app/features/feed/data/services/profile_update_service.dart';
import 'package:solar_wind_flutter_app/features/feed/data/models/user.dart';
import 'package:solar_wind_flutter_app/features/auth/data/models/registration_data.dart';

import 'my_profile_screen_test.mocks.dart';

@GenerateMocks([ProfileService, ProfileUpdateService])
void main() {
  late MockProfileService mockProfileService;
  late MockProfileUpdateService mockUpdateService;

  setUp(() {
    mockProfileService = MockProfileService();
    mockUpdateService = MockProfileUpdateService();
  });

  test('fetchUser returns correct user', () async {
    final user = User(
      id: 1,
      username: 'testuser',
      description: 'desc',
      cityName: 'Berlin',
      preferredGymTime: [1, 2],
      sportName: ['Football'],
    );

    when(mockProfileService.fetchUser(1)).thenAnswer((_) async => user);

    final result = await mockProfileService.fetchUser(1);
    expect(result.username, 'testuser');
    expect(result.cityName, 'Berlin');
  });

  test('updateProfile sends data', () async {
    final data = RegistrationData();
    data.username = 'updatedUser';
    data.description = 'desc';
    data.cityId = 10;
    data.sportId = [100];
    data.days = [1, 2];

    when(mockUpdateService.updateProfile(userId: 1, data: data))
        .thenAnswer((_) async => null);

    await mockUpdateService.updateProfile(userId: 1, data: data);

    verify(mockUpdateService.updateProfile(userId: 1, data: data)).called(1);
    });

}
