import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  final Box<Habit> _box = Hive.box<Habit>('habits');
  final Uuid _uuid = const Uuid();

  List<Habit> get habits => _box.values.toList()..sort((a, b) => a.name.compareTo(b.name));

  void addHabit(String name, String icon, Color color) {
    final habit = Habit(
      id: _uuid.v4(),
      name: name.trim(),
      icon: icon,
      color: color.value,
    );
    _box.add(habit);
    notifyListeners();
  }

  void deleteHabit(Habit habit) {
    habit.delete();
    notifyListeners();
  }

  void toggleHabit(Habit habit) {
    habit.toggleToday();
    notifyListeners();
  }
}