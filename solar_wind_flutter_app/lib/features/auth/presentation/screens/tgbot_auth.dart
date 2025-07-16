import 'package:flutter/material.dart';
import 'package:solar_wind_flutter_app/features/auth/presentation/screens/enter_code.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:solar_wind_flutter_app/l10n/app_localizations.dart';

class TelegramAuthScreen extends StatelessWidget {
  const TelegramAuthScreen({super.key});

  void _openTelegramBot(BuildContext context) async {
    const botUrl = 'https://t.me/SolarWindAuthorization_bot';
    if (await canLaunchUrl(Uri.parse(botUrl))) {
      await launchUrl(Uri.parse(botUrl));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => EnterCodeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open Telegram.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Telegram Authorization"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer, 
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.authorizationInstruction,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _openTelegramBot(context),
              child: const Text('@SolarWindAuthorization_bot'),
            ),
          ],
        ),
      ),
    );
  }
}
