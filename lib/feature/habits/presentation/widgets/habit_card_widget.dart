import 'package:curso_clean_arch/core/di/injector_container.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/delete_habit_cubit.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/delete_habit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitCard extends StatelessWidget {
  final void Function() onDeleteCubit;
  const HabitCard({super.key, required this.habit, required this.onDeleteCubit,});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    final cubit = DeleteHabitCubit(sl());

    return Card(
      child: ListTile(
        title: Text(habit.title),
        trailing: Column(
          children: [
            IconButton(
              onPressed: () {
                cubit.deleteHabit(habit.id);
              },
              icon: BlocConsumer<DeleteHabitCubit, DeleteHabitState>(
                listener: (context, state) {
                  if(state is SuccessDeletingHabitState){
                    onDeleteCubit();
                  }
                  if(state is ErrorDeletingHabitState){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao deletar hábito: ${state.error}")));
                  }
                },
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
