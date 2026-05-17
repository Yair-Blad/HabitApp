import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/habit.dart';
import '../../providers/habit_provider.dart';

class HabitCard extends ConsumerWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = habit.isCompletedToday();
    final theme = Theme.of(context);
    final habitColor = Color(habit.color);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => ref.read(habitProvider.notifier).toggleHabit(habit),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? habitColor
                        : habitColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isCompleted
                        ? const Icon(
                            Icons.check_rounded,
                            key: ValueKey('check'),
                            color: Colors.white,
                            size: 28,
                          )
                        : Text(
                            habit.icon,
                            key: ValueKey(habit.icon),
                            style: const TextStyle(fontSize: 28),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: isCompleted
                              ? theme.colorScheme.onSurface.withOpacity(0.5)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _StreakBadge(streak: habit.streak),
                          const SizedBox(width: 8),
                          Text(
                            '${habit.completedDates.length} total',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: theme.colorScheme.error.withOpacity(0.6),
                  ),
                  onPressed: () =>
                      ref.read(habitProvider.notifier).deleteHabit(habit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;

  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: streak > 0
            ? Colors.orange.withOpacity(0.15)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (streak > 0)
            Icon(
              Icons.local_fire_department_rounded,
              size: 14,
              color: Colors.orange.shade700,
            ),
          if (streak > 0) const SizedBox(width: 4),
          Text(
            streak > 0 ? '$streak day streak' : 'No streak',
            style: theme.textTheme.labelSmall?.copyWith(
              color: streak > 0
                  ? Colors.orange.shade700
                  : theme.colorScheme.onSurface.withOpacity(0.4),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
