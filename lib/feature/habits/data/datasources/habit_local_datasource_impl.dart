import 'package:curso_clean_arch/core/database/app_database.dart';
import 'package:curso_clean_arch/core/database/tables/habits_table.dart';
import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/data/datasources/habit_local_datasource.dart';
import 'package:curso_clean_arch/feature/habits/data/models/habit_model.dart';
import 'package:sqflite/sqflite.dart';

class HabitLocalDatasourceImpl implements HabitLocalDatasource {
  Future<Database> get _db async => AppDatabase.instance;

  @override
  Future<Result<void>> deleteHabit(String id) async {
    try {
      final db = await _db;

      await db.delete(habitsTableName, where: "id = ?", whereArgs: [id]);
      return Success(null);
    } on Exception catch (error) {
      return Error(error);
    }
  }

  @override
  Future<Result<List<HabitModel>>> getHabits() async {
    try {
      final db = await _db;
      final habitsMap = await db.query(habitsTableName);

      return Success(habitsMap.map(HabitModel.fromMap).toList());
    } on Exception catch (error) {
      return Error(error);
    }
  }

  @override
  Future<Result<void>> insertHabit(HabitModel habit) async {
    try {
      final db = await _db;

      await db.insert(
        habitsTableName,
        habit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return Success(null);
    } on Exception catch (error) {
      return Error(error);
    }
  }

  @override
  Future<Result<void>> updateHabit(HabitModel habit) async {
    try {
      final db = await _db;

      await db.update(
        habitsTableName,
        habit.toMap(),
        where: "id = ?",
        whereArgs: [habit.id],
      );

      return Success(null);
    } on Exception catch (error) {
      return Error(error);
    }
  }
}
