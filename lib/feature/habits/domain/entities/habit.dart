class Habit {
  final String id;
  final String title;
  final DateTime createdAt;
  const Habit({required this.id, required this.title, required this.createdAt});

  Habit copyWith({String? id, String? title, DateTime? createdAt}) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
