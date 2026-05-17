import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../models/habit.dart';

final habitBoxProvider = Provider<Box<Habit>>((ref) {
  return Hive.box<Habit>(AppConstants.habitsBox);
});

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) {
  final box = ref.watch(habitBoxProvider);
  return HabitNotifier(box);
});

class HabitNotifier extends StateNotifier<List<Habit>> {
  final Box<Habit> _box;
  final Uuid _uuid = const Uuid();
  StreamSubscription<BoxEvent>? _subscription;

  HabitNotifier(this._box) : super(_box.values.toList()..sort(_compareHabits)) {
    _subscription = _box.watch().listen((event) {
      state = _box.values.toList()..sort(_compareHabits);
    });
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
