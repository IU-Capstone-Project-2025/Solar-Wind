import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/services/city_service.dart';
import '../../data/models/city.dart';
import '../screens/sport_screen.dart';
import '../../presentation/state/registration_provider.dart';
import 'package:solar_wind_flutter_app/l10n/app_localizations.dart';

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({super.key});

  @override
  State<ChooseCityScreen> createState() => _ChooseCityScreenState();
}

class _ChooseCityScreenState extends State<ChooseCityScreen> {
  final cityService = CityService();
  final controller = TextEditingController();
  List<City> cities = [];
  bool isLoading = false;
  City? _selectedCity;

  void _search(String query) async {
    if (query.trim().isEmpty) {
      setState(() => cities = []);
      return;
    }

    setState(() => isLoading = true);
    try {
      final results = await cityService.searchCities(query);
      setState(() => cities = results);
    } catch (e) {
      print('City search error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _goNext() {
    if (_selectedCity != null) {
      final provider = Provider.of<RegistrationProvider>(context, listen: false);
      provider.setCity(_selectedCity!);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChooseSportScreen(selectedCity: _selectedCity!),
        ),
      );
    }
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
        title: Text(AppLocalizations.of(context)!.city),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer, 
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onChanged: _search,
              decoration: const InputDecoration(
                hintText: 'Search city...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (isLoading)
            const CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  final isSelected = _selectedCity?.id == city.id;
                  return ListTile(
                    title: Text(city.name),
                    selected: isSelected,
                    onTap: () {
                      setState(() => _selectedCity = city);
                    },
                  );
                },
              ),
            ),
          if (_selectedCity != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _goNext,
                child: Text(AppLocalizations.of(context)!.next),
              ),
            ),
        ],
      ),
    );
  }
}
