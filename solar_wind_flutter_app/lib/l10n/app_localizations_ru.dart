// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get myProfile => 'Мой профиль';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get gymbro => 'Найди своего gym bro';

  @override
  String get name => 'Имя';

  @override
  String get about => 'О тебе';

  @override
  String get next => 'Далее';

  @override
  String get tell => 'Расскажи о себе';

  @override
  String get city => 'Город';

  @override
  String get moveMeetRepeat => 'Двигайся. Знакомься. Повторяй.';

  @override
  String get changeLanguage => 'Сменить язык';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get enterName => 'Введите имя';

  @override
  String get selectCity => 'Выберите город';

  @override
  String get searchCity => 'Поиск города';

  @override
  String get sports => 'Виды спорта';

  @override
  String get searchSports => 'Поиск видов спорта';

  @override
  String get logout => 'Выйти';

  @override
  String get profileUpdated => 'Профиль обновлён';

  @override
  String get updateFailed => 'Ошибка при обновлении профиля';

  @override
  String get profileLoadError => 'Не удалось загрузить профиль';

  @override
  String get authorizationInstruction =>
      'Для авторизации нажмите кнопку ниже и напишите /start в Telegram-боте. Вы получите код';
}
