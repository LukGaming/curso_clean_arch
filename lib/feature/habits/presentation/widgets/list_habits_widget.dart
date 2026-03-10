import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/presentation/widgets/habit_card_widget.dart';
import 'package:flutter/material.dart';

class ListHabitsWidget extends StatelessWidget {
  final List<Habit> habits;
  final void Function() onDeleteCubit;
  const ListHabitsWidget({super.key, required this.habits, required this.onDeleteCubit,});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final habit = habits[index];
        return HabitCard(habit: habit, onDeleteCubit: onDeleteCubit,);
      },
      itemCount: habits.length,
    );
  }
}
