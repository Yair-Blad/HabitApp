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
    final today = DateTime.now().toIso8601String().split('T').first;
    return completedDates.contains(today);
  }

  int get streak {
    var count = 0;
    final today = DateTime.now();
    for (var i = 0; i < 365; i++) {
      final date = today.subtract(Duration(days: i));
      final dateStr = date.toIso8601String().split('T').first;
      if (completedDates.contains(dateStr)) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  void toggleToday() {
    final today = DateTime.now().toIso8601String().split('T').first;
    if (completedDates.contains(today)) {
      completedDates.remove(today);
    } else {
      completedDates.add(today);
    }
    save();
  }
}
