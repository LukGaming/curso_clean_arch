import 'package:curso_clean_arch/core/di/injector_container.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/delete_habit_cubit.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/delete_habit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    final cubit = sl<DeleteHabitCubit>();

    return Card(
      child: ListTile(
        title: Text(habit.title),
        trailing: Column(
          children: [
            IconButton(
              onPressed: () {
                cubit.deleteHabit(habit.id);
              },
              icon: BlocBuilder<DeleteHabitCubit, DeleteHabitState>(
                bloc: cubit,
                builder: (context, state) {
                  if(state is DeletingHabitState && state.deletingId == habit.id){
                    return CircularProgressIndicator();
                  }
                  return Icon(Icons.delete);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
