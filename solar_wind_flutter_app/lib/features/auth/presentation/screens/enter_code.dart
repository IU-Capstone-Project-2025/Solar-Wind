import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/auth_service.dart';
import 'city_screen.dart';
import '../../../feed/presentation/screen/user_feed_screen.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final controller = TextEditingController();
  bool _loading = false;
  final _authService = AuthService();

  void _submit() async {
    final code = controller.text.trim();
    if (code.isEmpty) return;

    setState(() => _loading = true);
    try {
      final auth = await _authService.sendCode(code);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('telegram_id', auth.id.toString());
      await prefs.setString('token', auth.token);
      if (auth.isRegistered) {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => UserFeedScreen(
          ),
        ),
      );
      } else {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChooseCityScreen(
          ),
        ),
      );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authorization failed: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter code"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer, 
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Enter code'),
            ),
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Continue'),
                  ),
          ],
        ),
      ),
    );
  }
}
