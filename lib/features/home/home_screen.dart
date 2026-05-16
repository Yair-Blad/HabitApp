import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/habit_provider.dart';
import '../add_habit/add_habit_screen.dart';
import 'widgets/habit_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habito', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: provider.habits.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events_outlined, size: 90, color: Colors.grey),
                  SizedBox(height: 20),
                  Text('Aún no tienes hábitos', style: TextStyle(fontSize: 22)),
                  Text('Presiona + para agregar uno'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.habits.length,
              itemBuilder: (context, index) {
                return HabitCard(habit: provider.habits[index]);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddHabitScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo hábito'),
      ),
    );
  }
}