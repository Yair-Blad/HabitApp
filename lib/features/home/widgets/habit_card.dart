import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/models/habit.dart';
import '../../../core/providers/habit_provider.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context, listen: false);
    final isCompleted = habit.isCompletedToday();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Color(habit.color).withOpacity(0.15),
          child: Text(habit.icon, style: const TextStyle(fontSize: 32)),
        ),
        title: Text(
          habit.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${habit.completedDates.length} días completados'),
        trailing: GestureDetector(
          onTap: () => provider.toggleHabit(habit),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? Color(habit.color) : Colors.grey[300],
            ),
            child: Icon(
              isCompleted ? Icons.check_rounded : Icons.circle_outlined,
              color: isCompleted ? Colors.white : Colors.grey[700],
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}