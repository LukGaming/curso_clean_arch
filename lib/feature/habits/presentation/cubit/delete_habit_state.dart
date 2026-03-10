abstract class DeleteHabitState {}

 class DeleteHabitStateInitial implements DeleteHabitState{}

 class DeletingHabitState implements DeleteHabitState {
    final String deletingId;

  DeletingHabitState(this.deletingId);
 }

 class SuccessDeletingHabitState implements DeleteHabitState {}

 class ErrorDeletingHabitState implements DeleteHabitState {
  final String error;

  ErrorDeletingHabitState(this.error);
 }
