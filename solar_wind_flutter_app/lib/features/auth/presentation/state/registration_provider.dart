// lib/features/auth/presentation/state/registration_provider.dart
import 'package:flutter/foundation.dart';
import '../../data/models/registration_data.dart';
import '../../data/models/city.dart';
import '../../data/models/sport.dart';

class RegistrationProvider extends ChangeNotifier {
  final RegistrationData _data = RegistrationData();

  RegistrationData get data => _data;

  void setName(String name) {
    _data.username = name;
    notifyListeners();
  }

  void setAbout(String about) {
    _data.description = about;
    notifyListeners();
  }

  void setCity(City city) {
    _data.cityId = city.id;
    notifyListeners();
  }

  void setSports(List<Sport> sports) {
    _data.sportId = sports.map((s) => s.id).toList();
    notifyListeners();
  }

  void setGender(String gender) {
  _data.gender = gender;
  notifyListeners();
}

void setPreferredGender(String preferredGender) {
  _data.preferredGender = preferredGender;
  notifyListeners();
}

void setBirthDate(DateTime date) {
  _data.birthDate = date;
  notifyListeners();
}

void reset() {
  _data.username = null;
  _data.description = null;
  _data.cityId = null;
  _data.gender = null;
  _data.preferredGender = null;
  _data.birthDate = null;
  _data.sportId.clear();
  notifyListeners();
}
}
