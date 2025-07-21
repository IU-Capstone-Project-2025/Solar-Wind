import 'package:solar_wind_flutter_app/features/feed/data/models/user.dart';

final mockUsers = <User>[
  User(
    id: 1001,
    username: 'fake_user_1',
    description: 'Just testing things out',
    cityName: 'Fake City',
    preferredGymTime: [1],
    sportName: ['TestSport'],
  ),
  User(
    id: 1002,
    username: 'test_account_2',
    description: 'Here for fun 🧪',
    cityName: 'SimCity',
    preferredGymTime: [1, 2],
    sportName: ['Debugging'],
  ),
  User(
    id: 1003,
    username: 'gym_bot_3000',
    description: '💥 Automated fitness bot',
    cityName: 'Botland',
    preferredGymTime: [6],
    sportName: ['Powerlifting', 'Running'],
  ),
  User(
    id: 1004,
    username: 'qa_guru',
    description: 'Finding bugs and gains 🐛🏋️',
    cityName: 'QApolis',
    preferredGymTime: [4],
    sportName: ['CrossFit'],
  ),
  User(
    id: 1005,
    username: 'frontend_beast',
    description: 'CSS by day, squats by night',
    cityName: 'Codeville',
    preferredGymTime: [2],
    sportName: ['Yoga', 'Climbing'],
  ),
];
