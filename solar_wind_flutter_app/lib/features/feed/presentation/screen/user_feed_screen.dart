import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_wind_flutter_app/features/feed/data/models/user.dart';
import 'package:solar_wind_flutter_app/features/feed/data/services/feed_service.dart';
import 'package:solar_wind_flutter_app/core/theme/theme_provider.dart';

import 'profile_screen.dart';
import 'my_profile_screen.dart';
import 'notifications_screen.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  final FeedService _feedService = FeedService();
  List<User> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFeed();
  }

  Future<void> _fetchFeed() async {
    try {
      final users = await _feedService.fetchFeed();
      setState(() {
        _users = users;
      });
    } catch (e) {
      print('Error fetching feed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load feed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            width: double.infinity,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Профиль
                IconButton(
                  iconSize: 32,
                  icon: Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  onPressed: () {
                    const userId = 637451540;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyProfileScreen(userId: userId),
                      ),
                    );
                  },
                ),

                // Переключение темы
                IconButton(
                  iconSize: 28,
                  icon: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  onPressed: () {
                    context.read<ThemeProvider>().toggleTheme();
                  },
                ),

                IconButton(
                  iconSize: 32,
                  icon: Icon(Icons.notifications, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      final user = _users[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserProfileScreen(userId: user.id),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            color: Theme.of(context).cardColor,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.username,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        user.description,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        children: user.sportName
                                            .map((sport) => Chip(
                                                  label: Text(sport),
                                                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                                  labelStyle: TextStyle(
                                                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                const Positioned(
                                  top: 8,
                                  right: 8,
                                  child: LikeButton(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      isLiked = !isLiked;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        iconSize: 32,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: isLiked
              ? const Icon(Icons.favorite, color: Colors.red, key: ValueKey('liked'))
              : Icon(Icons.favorite_border, color: Theme.of(context).iconTheme.color, key: const ValueKey('unliked')),
        ),
        onPressed: _onTap,
      ),
    );
  }
}
