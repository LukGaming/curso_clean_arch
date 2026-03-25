import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/data/datasources/habit_local_datasource.dart';
import 'package:curso_clean_arch/feature/habits/data/models/habit_model.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDatasource _dataSource;

  const HabitRepositoryImpl(this._dataSource);

  @override
  Future<Result<void>> delete(String id) async {
    return await _dataSource.deleteHabit(id);
  }

  @override
  Future<Result<List<Habit>>> get() async {
    final result = await _dataSource.getHabits();

    switch (result) {
      case Success<List<HabitModel>>():
        final entities = result.value.map((model) => model.toEntity()).toList();
        return Success(entities);
      case Error():
        return Error(result.error);
    }
  }

  @override
  Future<Result<void>> insert(Habit habit) async {
    return await _dataSource.insertHabit(HabitModel.fromEntity(habit));
  }

  @override
  Future<Result<void>> update(Habit habit) async {
    return await _dataSource.updateHabit(HabitModel.fromEntity(habit));
  }
}
