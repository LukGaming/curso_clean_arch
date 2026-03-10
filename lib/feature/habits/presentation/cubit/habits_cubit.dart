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

    try {
      final habits = await _getHabitsUsecase();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> insertHabit(String title) async {
    try {
      final habit = Habit(
        id: Uuid().v4(),
        title: title,
        createdAt: DateTime.now(),
      );
      await _insertHabitUseCase(habit);
      await getHabits();
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  Future<void> editHabit(Habit habit) async {
    try {
      await _updateHabitUsecase(habit);
      await getHabits();
    } catch (e) {
      emit(HabitsError(e.toString()));
    }
  }

  
}
