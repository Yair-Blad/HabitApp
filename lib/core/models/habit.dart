import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String icon;

  @HiveField(3)
  int color;

  @HiveField(4)
  List<String> completedDates;

  Habit({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    List<String>? completedDates,
  }) : completedDates = completedDates ?? [];

  bool isCompletedToday() {
    String today = DateTime.now().toIso8601String().split('T')[0];
    return completedDates.contains(today);
  }

  void toggleToday() {
    String today = DateTime.now().toIso8601String().split('T')[0];
    if (completedDates.contains(today)) {
      completedDates.remove(today);
    } else {
      completedDates.add(today);
    }
    save();
  }
}