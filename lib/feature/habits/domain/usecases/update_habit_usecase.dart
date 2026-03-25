import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';

class UpdateHabitUsecase {
  final HabitRepository _repository;

  const UpdateHabitUsecase(this._repository);

  Future<Result<void>> call(Habit habit) async {
    return await _repository.update(habit);
  }
}
