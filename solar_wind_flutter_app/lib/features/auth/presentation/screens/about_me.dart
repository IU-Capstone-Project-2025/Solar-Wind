import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/state/registration_provider.dart';
import 'gender_and_birth_screen.dart';

import 'package:solar_wind_flutter_app/l10n/app_localizations.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final nameController = TextEditingController();
  final aboutController = TextEditingController();

  bool get isNameValid => nameController.text.trim().isNotEmpty;

  void _onChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    nameController.addListener(_onChanged);
  }

  @override
  void dispose() {
    nameController.removeListener(_onChanged);
    nameController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  void _goNext() {
    final name = nameController.text.trim();
    final about = aboutController.text.trim();

    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.setName(name);
    provider.setAbout(about);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GenderAndBirthScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tell),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer, 
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 👤 Имя
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // 📄 Описание
            TextField(
              controller: aboutController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.about,
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const Spacer(),
            // 🔘 Кнопка Далее
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isNameValid ? _goNext : null,
                child: Text(AppLocalizations.of(context)!.next),
              ),
            )
          ],
        ),
      ),
    );
  }
}
