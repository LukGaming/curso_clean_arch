import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';

abstract class HabitRepository {
  Future<void> insert(Habit habit);
  Future<List<Habit>> get();
  Future<void> update(Habit habit);
  Future<void> delete(String id);
}
