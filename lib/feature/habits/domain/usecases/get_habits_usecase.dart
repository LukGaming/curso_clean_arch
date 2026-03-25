import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';

class GetHabitsUsecase {
  final HabitRepository _repository;

  const GetHabitsUsecase(this._repository);

  Future<Result<List<Habit>>> call() async {
    return await _repository.get();
  }
}
