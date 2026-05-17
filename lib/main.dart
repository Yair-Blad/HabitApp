import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter_io/hive_flutter_io.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/constants/app_constants.dart';
import 'features/habits/models/habit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox<Habit>(AppConstants.habitsBox);

  runApp(
    const ProviderScope(
      child: HabitoApp(),
    ),
  );
}
