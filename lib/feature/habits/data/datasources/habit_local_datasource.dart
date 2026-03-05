import 'package:curso_clean_arch/feature/habits/data/models/habit_model.dart';

abstract class HabitLocalDatasource {
  Future<void> insertHabit(HabitModel habit);
  Future<List<HabitModel>> getHabits();
  Future<void> updateHabit(HabitModel habit);
  Future<void> deleteHabit(String id);
}
