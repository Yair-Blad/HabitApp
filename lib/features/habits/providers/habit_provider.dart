import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter_io/hive_flutter_io.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../models/habit.dart';

final habitBoxProvider = Provider<Box<Habit>>((ref) {
  return Hive.box<Habit>(AppConstants.habitsBox);
});

final habitProvider = NotifierProvider<HabitNotifier, List<Habit>>(HabitNotifier.new);

class HabitNotifier extends Notifier<List<Habit>> {
  final Uuid _uuid = const Uuid();
  StreamSubscription<BoxEvent>? _subscription;

  Box<Habit> get _box => ref.read(habitBoxProvider);

  @override
  List<Habit> build() {
    final box = _box;
    final habits = box.values.toList()..sort(_compareHabits);
    _subscription = box.watch().listen((event) {
      state = box.values.toList()..sort(_compareHabits);
    });
    return habits;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  List<Habit> get habits => state;

  void addHabit(String name, String icon, int color) {
    final habit = Habit(
      id: _uuid.v4(),
      name: name.trim(),
      icon: icon,
      color: color,
    );
    _box.add(habit);
  }

  void deleteHabit(Habit habit) {
    habit.delete();
  }

  void toggleHabit(Habit habit) {
    habit.toggleToday();
    state = [..._box.values.toList()..sort(_compareHabits)];
  }

  int get totalCompletedToday {
    final today = DateTime.now().toIso8601String().split('T').first;
    return state.where((h) => h.completedDates.contains(today)).length;
  }

  int get totalHabits => state.length;

  static int _compareHabits(Habit a, Habit b) {
    final aCompleted = a.isCompletedToday();
    final bCompleted = b.isCompletedToday();
    if (aCompleted && !bCompleted) return 1;
    if (!aCompleted && bCompleted) return -1;
    return a.name.compareTo(b.name);
  }
}
