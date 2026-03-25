import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/data/models/habit_model.dart';

abstract class HabitLocalDatasource {
  Future<Result<void>> insertHabit(HabitModel habit);
  Future<Result<List<HabitModel>>> getHabits();
  Future<Result<void>> updateHabit(HabitModel habit);
  Future<Result<void>> deleteHabit(String id);
}
