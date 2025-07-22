import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_wind_flutter_app/features/auth/data/models/city.dart';
import 'package:solar_wind_flutter_app/features/auth/data/models/registration_data.dart';
import 'package:solar_wind_flutter_app/features/auth/data/models/sport.dart';
import 'package:solar_wind_flutter_app/features/auth/data/services/city_service.dart';
import 'package:solar_wind_flutter_app/features/auth/data/services/sport_service.dart';
import 'package:solar_wind_flutter_app/features/auth/presentation/screens/welcome_screen.dart';
import 'package:solar_wind_flutter_app/features/feed/data/services/profile_service.dart';
import 'package:solar_wind_flutter_app/features/feed/data/services/profile_update_service.dart';
import 'package:solar_wind_flutter_app/data/services/photo_get_service.dart';
import 'package:solar_wind_flutter_app/data/services/photo_post_service.dart';

class MyProfileScreen extends StatefulWidget {
  final int userId;

  const MyProfileScreen({super.key, required this.userId});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profileService = ProfileService();
  final _updateService = ProfileUpdateService();
  final _cityService = CityService();
  final _sportService = SportService();
  final _photoGetService = PhotoGetService();
  final _photoPostService = PhotoPostService();
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = true;
  bool _isUploading = false;
  RegistrationData _data = RegistrationData();
  bool _showDaysSelection = false;
  Uint8List? _profilePhoto;
  File? _newPhotoFile;

  // Город
  final _citySearchController = TextEditingController();
  List<City> _citySearchResults = [];
  City? _selectedCity;

  // Спорт
  final _sportSearchController = TextEditingController();
  List<Sport> _sportSearchResults = [];
  List<Sport> _selectedSports = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _citySearchController.addListener(_onCitySearchChanged);
    _sportSearchController.addListener(_onSportSearchChanged);
  }

  @override
  void dispose() {
    _citySearchController.dispose();
    _sportSearchController.dispose();
    super.dispose();
  }

  List<String> getWeekDayNames(List<int> days) {
    const weekDays = [
      'Monday',    // 1
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',    // 7
    ];
    return days.map((d) => weekDays[d - 1]).toList();
  }

  Future<void> _loadInitialData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final telegramIdString = prefs.getString('telegram_id');
    if (telegramIdString == null) {
      throw Exception('Telegram ID not found in SharedPreferences');
    }
    final telegramId = int.tryParse(telegramIdString);
    if (telegramId == null) {
      throw Exception('Telegram ID is not a valid number');
    }
    final user = await _profileService.fetchUser(telegramId);
    
    // Загружаем фото профиля по ID пользователя
    try {
      final photo = await _photoGetService.getPhoto(telegramId); // Используем telegramId вместо user.photoId
      setState(() => _profilePhoto = photo);
    } catch (e) {
      print('Error loading profile photo: $e');
    }

    final cities = await _cityService.searchCities('');
    final sports = await _sportService.searchSports('');

    final city = cities.firstWhere(
      (c) => c.name == user.cityName,
      orElse: () => cities.first,
    );

    final selectedSports = sports.where((s) => user.sportName.contains(s.name)).toList();

    setState(() {
      _data.username = user.username;
      _data.description = user.description;
      _selectedCity = city;
      _data.cityId = city.id;
      _selectedSports = selectedSports;
      _data.sportId = selectedSports.map((s) => s.id).toList();
      _data.days = user.preferredGymTime;

      _citySearchResults = cities;
      _sportSearchResults = sports;
      _citySearchController.text = city.name;
      _isLoading = false;
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to load profile: $e")),
    );
    setState(() => _isLoading = false);
  }
}

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _newPhotoFile = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  Future<void> _uploadPhoto() async {
  if (_newPhotoFile == null) return;

  setState(() => _isUploading = true);
  try {
    await _photoPostService.sendPhoto(_newPhotoFile!);
    
    // После успешной загрузки обновляем фото
    final prefs = await SharedPreferences.getInstance();
    final telegramIdString = prefs.getString('telegram_id');
    if (telegramIdString != null) {
      final telegramId = int.tryParse(telegramIdString);
      if (telegramId != null) {
        try {
          final photo = await _photoGetService.getPhoto(telegramId);
          setState(() {
            _profilePhoto = photo;
            _newPhotoFile = null;
          });
        } catch (e) {
          print('Error loading updated photo: $e');
        }
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile photo updated successfully')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to upload photo: $e')),
    );
  } finally {
    setState(() => _isUploading = false);
  }
}

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => WelcomeScreen(),
      ),
      (route) => false,
    );
  }

  Future<void> _onCitySearchChanged() async {
    final query = _citySearchController.text.trim();
    if (query.isEmpty) {
      setState(() => _citySearchResults = []);
      return;
    }
    final results = await _cityService.searchCities(query);
    setState(() => _citySearchResults = results);
  }

  Future<void> _onSportSearchChanged() async {
    final query = _sportSearchController.text.trim();
    if (query.isEmpty) {
      setState(() => _sportSearchResults = []);
      return;
    }
    final results = await _sportService.searchSports(query);
    setState(() => _sportSearchResults = results);
  }

  void _selectCity(City city) {
    setState(() {
      _selectedCity = city;
      _data.cityId = city.id;
      _citySearchController.text = city.name;
      _citySearchResults = [];
      FocusScope.of(context).unfocus();
    });
  }

  void _addSport(Sport sport) {
    if (_selectedSports.any((s) => s.id == sport.id)) return;
    setState(() {
      _selectedSports.add(sport);
      _data.sportId.add(sport.id);
      _sportSearchController.clear();
      _sportSearchResults = [];
    });
  }

  void _removeSport(Sport sport) {
    setState(() {
      _selectedSports.removeWhere((s) => s.id == sport.id);
      _data.sportId.removeWhere((id) => id == sport.id);
    });
  }

  void _toggleDaySelection(int day) {
    setState(() {
      if (_data.days.contains(day)) {
        _data.days.remove(day);
      } else {
        _data.days.add(day);
      }
      _data.days.sort();
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _updateService.updateProfile(userId: widget.userId, data: _data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile: $e")),
        );
      }
    }
  }

  Widget _buildCitySearchField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("City", style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _citySearchController,
          decoration: InputDecoration(
            hintText: "Search city",
            border: const OutlineInputBorder(),
            fillColor: theme.colorScheme.surface,
            filled: true,
          ),
          validator: (_) => _selectedCity == null ? 'Select a city' : null,
          style: theme.textTheme.bodyMedium,
        ),
        if (_citySearchResults.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 150),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(4),
              color: theme.colorScheme.surface,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _citySearchResults.length,
              itemBuilder: (context, index) {
                final city = _citySearchResults[index];
                return ListTile(
                  title: Text(city.name, style: theme.textTheme.bodyMedium),
                  onTap: () => _selectCity(city),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildSportSearchField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sports", style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: _selectedSports
              .map((sport) => Chip(
                    label: Text(
                      sport.name,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
                    ),
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    onDeleted: () => _removeSport(sport),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _sportSearchController,
          decoration: InputDecoration(
            hintText: "Search sports",
            border: const OutlineInputBorder(),
            fillColor: theme.colorScheme.surface,
            filled: true,
          ),
          style: theme.textTheme.bodyMedium,
        ),
        if (_sportSearchResults.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 150),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(4),
              color: theme.colorScheme.surface,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _sportSearchResults.length,
              itemBuilder: (context, index) {
                final sport = _sportSearchResults[index];
                return ListTile(
                  title: Text(sport.name, style: theme.textTheme.bodyMedium),
                  onTap: () => _addSport(sport),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildWeekDaysSelector(ThemeData theme) {
    const days = [
      {'id': 1, 'name': 'Mon'},
      {'id': 2, 'name': 'Tue'},
      {'id': 3, 'name': 'Wed'},
      {'id': 4, 'name': 'Thu'},
      {'id': 5, 'name': 'Fri'},
      {'id': 6, 'name': 'Sat'},
      {'id': 7, 'name': 'Sun'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Training days",
              style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(
                _showDaysSelection ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              onPressed: () {
                setState(() {
                  _showDaysSelection = !_showDaysSelection;
                });
              },
            ),
          ],
        ),
        if (_showDaysSelection)
          Wrap(
            spacing: 8,
            children: days.map((day) {
              final isSelected = _data.days.contains(day['id']);
              return FilterChip(
                label: Text(day['name'] as String),
                selected: isSelected,
                onSelected: (_) => _toggleDaySelection(day['id'] as int),
                selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                checkmarkColor: theme.colorScheme.primary,
                labelStyle: TextStyle(
                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                ),
              );
            }).toList(),
          ),
        if (!_showDaysSelection && _data.days.isNotEmpty)
          Wrap(
            spacing: 8,
            children: getWeekDayNames(_data.days)
                .map((day) => Chip(label: Text(day)))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildProfilePhotoSection(ThemeData theme) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: theme.colorScheme.surfaceVariant,
              backgroundImage: _newPhotoFile != null 
                  ? FileImage(_newPhotoFile!) as ImageProvider
                  : _profilePhoto != null
                      ? MemoryImage(_profilePhoto!)
                      : null,
              child: _newPhotoFile == null && _profilePhoto == null
                  ? Icon(
                      Icons.person,
                      size: 60,
                      color: theme.colorScheme.onSurfaceVariant,
                    )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: theme.colorScheme.onPrimary),
                  onPressed: _pickImage,
                ),
              ),
            ),
          ],
        ),
        if (_newPhotoFile != null) ...[
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _isUploading ? null : _uploadPhoto,
            child: _isUploading
                ? const CircularProgressIndicator()
                : const Text('Save Photo'),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer, 
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: theme.colorScheme.primary))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildProfilePhotoSection(theme),
                    Text(
                      "Edit your profile",
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _data.username,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: const OutlineInputBorder(),
                        fillColor: theme.colorScheme.surface,
                        filled: true,
                      ),
                      style: theme.textTheme.bodyMedium,
                      onChanged: (value) => _data.username = value,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter username' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: _data.description,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: const OutlineInputBorder(),
                        fillColor: theme.colorScheme.surface,
                        filled: true,
                      ),
                      style: theme.textTheme.bodyMedium,
                      maxLines: 3,
                      onChanged: (value) => _data.description = value,
                    ),
                    const SizedBox(height: 12),
                    _buildCitySearchField(theme),
                    const SizedBox(height: 12),
                    _buildSportSearchField(theme),
                    const SizedBox(height: 12),
                    _buildWeekDaysSelector(theme),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveProfile,
                      child: const Text("Save Changes"),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }
}