import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';

abstract class HabitsState {
  const HabitsState();
}

class HabitsInitial extends HabitsState {}

class HabitsLoading extends HabitsState {}

class HabitsLoaded extends HabitsState {
  final List<Habit> habits;

  const HabitsLoaded(this.habits);
}

class HabitsError extends HabitsState {
  final String error;

  const HabitsError(this.error);
}

// HabitsInitial -> HabitsLoading -> (HabitsLoaded HabitsError);
