import 'package:flutter/material.dart';
import 'package:solar_wind_flutter_app/features/feed/data/services/profile_service.dart';
import 'package:solar_wind_flutter_app/features/feed/data/services/like_service.dart';
import 'package:solar_wind_flutter_app/features/feed/data/models/user.dart';
import 'package:solar_wind_flutter_app/data/services/photo_get_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:typed_data';

class UserProfileScreen extends StatefulWidget {
  final int userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> 
    with SingleTickerProviderStateMixin {
  final _profileService = ProfileService();
  final _likeService = LikeService();
  final _photoGetService = PhotoGetService();

  bool _isLoading = true;
  User? _user;
  bool _liked = false;
  Uint8List? _profilePhoto;

  late AnimationController _likeAnimationController;
  late Animation<double> _likeScaleAnimation;

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

  @override
  void initState() {
    super.initState();
    _loadUser();

    _likeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _likeScaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _likeAnimationController, curve: Curves.easeOutBack),
    );

    _likeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _likeAnimationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _profileService.fetchUser(widget.userId);
      
      // Загружаем фото, если у пользователя есть photoId
      
        try {
          final photo = await _photoGetService.getPhoto(user.id);
          setState(() => _profilePhoto = photo);
        } catch (e) {
          print('Error loading photo: $e');
          // Можно показать snackbar или просто оставить аватар по умолчанию
        }
      
      
      setState(() => _user = user);
    } catch (e) {
      print('Error loading profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _like() async {
    try {
      await _likeService.likeUser(widget.userId);
      setState(() => _liked = true);
      _likeAnimationController.forward();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User liked!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Like failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_user == null) {
      return const Scaffold(body: Center(child: Text('User not found')));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(_user!.username),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ScaleTransition(
              scale: _likeScaleAnimation,
              child: IconButton(
                iconSize: 36,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => 
                    ScaleTransition(scale: animation, child: child),
                  child: _liked
                    ? const Icon(Icons.favorite, color: Colors.red, key: ValueKey('liked'))
                    : const Icon(Icons.favorite_border, color: Colors.grey, key: ValueKey('unliked')),
                ),
                onPressed: _like,
                tooltip: 'Like',
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileAvatar(),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          _user!.description,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          'City: ${_user!.cityName}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          children: _user!.sportName
                              .map((sport) => Chip(
                                    label: Text(
                                      sport,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Chosen training days',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: getWeekDayNames(_user!.preferredGymTime)
                                  .map((day) => Chip(label: Text(day)))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    if (_profilePhoto != null) {
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[200],
        backgroundImage: MemoryImage(_profilePhoto!),
      );
    } else {
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.blueAccent,
        child: Text(
          _user!.username.isNotEmpty ? _user!.username[0].toUpperCase() : '?',
          style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}