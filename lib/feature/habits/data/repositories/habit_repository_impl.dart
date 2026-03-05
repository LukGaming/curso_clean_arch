import 'package:curso_clean_arch/feature/habits/data/datasources/habit_local_datasource.dart';
import 'package:curso_clean_arch/feature/habits/data/models/habit_model.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDatasource _dataSource;

  const HabitRepositoryImpl(this._dataSource);

  @override
  Future<void> delete(String id) async {
    await _dataSource.deleteHabit(id);
  }

  @override
  Future<List<Habit>> get() async {
    final models = await _dataSource.getHabits();

    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> insert(Habit habit) async {
    await _dataSource.insertHabit(HabitModel.fromEntity(habit));
  }

  @override
  Future<void> update(Habit habit) async {
    await _dataSource.updateHabit(HabitModel.fromEntity(habit));
  }
}
