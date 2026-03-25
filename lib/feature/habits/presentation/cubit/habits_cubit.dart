import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/get_habits_usecase.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/insert_habit_usecase.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/update_habit_usecase.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/habits_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class HabitsCubit extends Cubit<HabitsState> {
  final GetHabitsUsecase _getHabitsUsecase;
  final InsertHabitUseCase _insertHabitUseCase;
  final UpdateHabitUsecase _updateHabitUsecase;
  final DeleteHabitUsecase _deleteHabitUsecase;

  HabitsCubit(
    this._getHabitsUsecase,
    this._insertHabitUseCase,
    this._updateHabitUsecase,
    this._deleteHabitUsecase,
  ) : super(HabitsInitial());

  Future<void> getHabits() async {
    emit(HabitsLoading());

    final result = await _getHabitsUsecase();

    switch (result) {
      case Success():
        emit(HabitsLoaded(result.value));
      case Error():
        emit(HabitsError(result.error.toString()));
    }
  }

  Future<void> insertHabit(String title) async {
    final habit = Habit(
      id: Uuid().v4(),
      title: title,
      createdAt: DateTime.now(),
    );

    final result = await _insertHabitUseCase(habit);

    switch (result) {
      case Success():
        await getHabits();
      case Error():
        emit(HabitsError(result.error.toString()));
    }
  }

  Future<void> editHabit(Habit habit) async {
    final result = await _updateHabitUsecase(habit);

    switch (result) {
      case Success():
        await getHabits();
      case Error():
        emit(HabitsError(result.error.toString()));
    }
  }
}
