import 'package:curso_clean_arch/core/database/tables/habits_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _database;

  static Future<Database> get instance async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), "focus_flow.db");

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(createHabitsTable);
  }
}
