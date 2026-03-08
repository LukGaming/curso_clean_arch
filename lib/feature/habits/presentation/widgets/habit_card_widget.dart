import 'package:curso_clean_arch/core/di/injector_container.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/habits_cubit.dart';
import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    final cubit = sl<HabitsCubit>();

    return Card(
      child: ListTile(
        title: Text(habit.title),
        trailing: Column(
          children: [
            IconButton(
              onPressed: () {
                cubit.deleteHabit(habit.id);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
