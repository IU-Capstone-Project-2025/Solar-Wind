import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/sport.dart';
import '../../data/models/city.dart';
import '../../data/services/sport_service.dart';
import '../../presentation/state/registration_provider.dart';
import '../screens/about_me.dart';

class ChooseSportScreen extends StatefulWidget {
  final City selectedCity;

  const ChooseSportScreen({super.key, required this.selectedCity});

  @override
  State<ChooseSportScreen> createState() => _ChooseSportScreenState();
}

class _ChooseSportScreenState extends State<ChooseSportScreen> {
  final sportService = SportService();
  final controller = TextEditingController();
  List<Sport> allSports = [];
  List<Sport> selectedSports = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _search('');
  }

  void _search(String query) async {
    setState(() => isLoading = true);
    try {
      final results = await sportService.searchSports(query);
      setState(() => allSports = results);
    } catch (e) {
      print('Sport search error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _toggleSelection(Sport sport) {
    setState(() {
      if (selectedSports.contains(sport)) {
        selectedSports.remove(sport);
      } else {
        selectedSports.add(sport);
      }
    });
  }

  void _goNext() {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.setSports(selectedSports);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FillProfileScreen()),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Sports"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer, 
        elevation: 0,
      ),
      body: Column(
        children: [
          if (selectedSports.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                children: selectedSports
                    .map((s) => Chip(label: Text(s.name)))
                    .toList(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onChanged: _search,
              decoration: const InputDecoration(
                hintText: 'Search sports...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (isLoading)
            const CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                itemCount: allSports.length,
                itemBuilder: (context, index) {
                  final sport = allSports[index];
                  final isSelected = selectedSports.contains(sport);
                  return CheckboxListTile(
                    title: Text(sport.name),
                    value: isSelected,
                    onChanged: (_) => _toggleSelection(sport),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: selectedSports.isNotEmpty ? _goNext : null,
                child: const Text('Next'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
