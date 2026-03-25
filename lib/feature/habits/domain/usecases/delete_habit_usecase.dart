import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';

class DeleteHabitUsecase {
  final HabitRepository _repository;

  const DeleteHabitUsecase(this._repository);

  Future<Result<void>> call(String id) async {
    return await _repository.delete(id);
  }
}
