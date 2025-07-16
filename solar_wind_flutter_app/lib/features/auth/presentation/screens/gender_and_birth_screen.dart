import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/state/registration_provider.dart';
import '../../data/services/registration_service.dart';
import '../../../feed/presentation/screen/user_feed_screen.dart';

class GenderAndBirthScreen extends StatefulWidget {
  const GenderAndBirthScreen({super.key});

  @override
  State<GenderAndBirthScreen> createState() => _GenderAndBirthScreenState();
}

class _GenderAndBirthScreenState extends State<GenderAndBirthScreen> {
  String? gender;
  String? preferredGender;
  DateTime? birthDate;
  bool isLoading = false;

  void _selectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
    );

    if (picked != null) {
      setState(() => birthDate = picked);
    }
  }

  bool get isValid =>
      gender != null && preferredGender != null && birthDate != null;

  void _submit() async {
    if (!isValid) return;

    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.setGender(gender!);
    provider.setPreferredGender(preferredGender!);
    provider.setBirthDate(birthDate!);

    setState(() => isLoading = true);

    try {
      final service = RegistrationService();
      await service.register(provider.data);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isRegistered', true);

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const UserFeedScreen()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tell us about you'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer, 
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Your Gender'),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Male'),
                  selected: gender == 'male',
                  onSelected: (_) => setState(() => gender = 'male'),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Female'),
                  selected: gender == 'female',
                  onSelected: (_) => setState(() => gender = 'female'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Preferred Gender'),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Male'),
                  selected: preferredGender == 'male',
                  onSelected: (_) => setState(() => preferredGender = 'male'),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Female'),
                  selected: preferredGender == 'female',
                  onSelected: (_) => setState(() => preferredGender = 'female'),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Doesn’t matter'),
                  selected: preferredGender == 'any',
                  onSelected: (_) => setState(() => preferredGender = 'any'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(birthDate != null
                    ? 'Birth Date: ${birthDate!.toLocal()}'.split(' ')[0]
                    : 'Choose your birth date'),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _selectDate,
                  child: const Text('Select Date'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: isValid && !isLoading ? _submit : null,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Complete Registration'),
            ),
          ],
        ),
      ),
    );
  }
}
