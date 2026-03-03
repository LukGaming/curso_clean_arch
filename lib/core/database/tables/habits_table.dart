const String habitsTableName = "habits";
const String habitsTableId = "id";
const String habitsTableTitle = "title";
const String habitsTableCreatedAt = "created_at";

const String createHabitsTable =
    '''CREATE TABLE $habitsTableName(
          $habitsTableId TEXT PRIMARY KEY,
          $habitsTableTitle TEXT NOT NULL,
          $habitsTableCreatedAt TEXT NOT NULL
        )''';
