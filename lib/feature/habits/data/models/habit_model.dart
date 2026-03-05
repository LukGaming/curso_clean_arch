import 'package:curso_clean_arch/core/database/tables/habits_table.dart';

class HabitModel {
  final String id;
  final String title;
  final DateTime createdAt;

  const HabitModel({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map[habitsTableId],
      title: map[habitsTableTitle],
      createdAt: DateTime.parse(map[habitsTableCreatedAt]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      habitsTableId: id,
      habitsTableTitle: title,
      habitsTableCreatedAt: createdAt.toIso8601String(),
    };
  }
}
