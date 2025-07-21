import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../presentation/state/registration_provider.dart';
import '../../data/services/registration_service.dart';
import 'package:solar_wind_flutter_app/data/services/photo_post_service.dart';
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
  final _picker = ImagePicker();
  File? _selectedImage;

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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _goNext() async {
    final name = nameController.text.trim();
    final about = aboutController.text.trim();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);

    provider.setName(name);
    provider.setAbout(about);

    if (_selectedImage != null) {
      try {
        await PhotoPostService().sendPhoto(_selectedImage!);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload photo: $e')),
        );
        return;
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GenderAndBirthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.tell),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: loc.name,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: aboutController,
              decoration: InputDecoration(
                labelText: loc.about,
                border: const OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            Row(
  children: [
    _selectedImage != null
        ? Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer,
                width: 3,
              ),
              image: DecorationImage(
                image: FileImage(_selectedImage!),
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer,
                width: 3,
              ),
            ),
            child: const Icon(Icons.person, size: 40),
          ),
    const SizedBox(width: 12),
    ElevatedButton.icon(
      onPressed: _pickImage,
      icon: const Icon(Icons.photo),
      label: Text(loc.selectPhoto),
    ),
  ],
),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isNameValid ? _goNext : null,
                child: Text(loc.next),
              ),
            )
          ],
        ),
      ),
    );
  }
}
