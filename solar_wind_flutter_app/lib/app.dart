import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/presentation/screens/welcome_screen.dart';
import 'features/feed/presentation/screen/user_feed_screen.dart';
import 'features/auth/presentation/state/registration_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/localization/locale_provider.dart';  
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _decideStartScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final isRegistered = prefs.getBool('isRegistered') ?? false;
    if (isRegistered) {
      return const UserFeedScreen();
    } else {
      return const WelcomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(false)), // старт с false, потом можно обновить
        ChangeNotifierProvider(create: (_) => LocaleProvider()),       // провайдер локализации
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, _) {
          return MaterialApp(
            title: 'SolarWind App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            locale: localeProvider.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('ru'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) return supportedLocales.first;
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            home: FutureBuilder<Widget>(
              future: _decideStartScreen(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                return snapshot.data!;
              },
            ),
          );
        },
      ),
    );
  }
}
