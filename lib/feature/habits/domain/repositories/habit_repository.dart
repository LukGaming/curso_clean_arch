import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';

abstract class HabitRepository {
  Future<Result<void>> insert(Habit habit);
  Future<Result<List<Habit>>> get();
  Future<Result<void>> update(Habit habit);
  Future<Result<void>> delete(String id);
}
