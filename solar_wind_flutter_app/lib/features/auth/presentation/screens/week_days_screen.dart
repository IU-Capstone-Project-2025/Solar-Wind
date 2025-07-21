import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_wind_flutter_app/l10n/app_localizations.dart';
import 'package:solar_wind_flutter_app/features/auth/presentation/screens/about_me.dart';
import 'package:solar_wind_flutter_app/features/auth/presentation/state/registration_provider.dart';

class WeekDaysScreen extends StatefulWidget {
  final List<int> initiallySelected;

  const WeekDaysScreen({
    super.key,
    required this.initiallySelected,
  });

  @override
  State<WeekDaysScreen> createState() => _WeekDaysScreenState();
}

class _WeekDaysScreenState extends State<WeekDaysScreen> {
  late List<int> selectedDays;

  @override
  void initState() {
    super.initState();
    selectedDays = [...widget.initiallySelected];
  }

  void toggleDay(int day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  void _goNext() {
    Provider.of<RegistrationProvider>(context, listen: false)
        .setWorkoutDays(selectedDays..sort());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const FillProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final days = [
      t.monday,
      t.tuesday,
      t.wednesday,
      t.thursday,
      t.friday,
      t.saturday,
      t.sunday,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(t.chooseWorkoutDays),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer, 
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: days.length,
              itemBuilder: (context, index) {
                final dayNumber = index + 1; // 1 — Monday
                final isSelected = selectedDays.contains(dayNumber);
                return ListTile(
                  title: Text(days[index]),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () => toggleDay(dayNumber),
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
                onPressed: selectedDays.isNotEmpty ? _goNext : null,
                child: Text(t.next),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
