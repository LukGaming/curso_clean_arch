sealed class Result<T> {
  const Result();
}

///
///
/// Future<Result<List<Habit>>> getHabits();
///
///
class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);
}

class Error<T> extends Result<T> {
  final Exception error;

  Error(this.error);
}
