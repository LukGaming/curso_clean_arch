import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/get_habits_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/repository_mocks.dart';

void main() {
  late HabitRepository habitRepository;
  late GetHabitsUsecase insertHabitUseCase;

  setUp(() {
    habitRepository = MockHabitRepository();
    insertHabitUseCase = GetHabitsUsecase(habitRepository);
  });

  group('GetHabitsUseCase testes', () {
    test("Deve buscar os habitos corretamente", () async {
      final habitsList = [
        Habit(
          id: "first_habit",
          title: "Primeiro hábito",
          createdAt: DateTime.now(),
        ),
        Habit(
          id: "second_habit",
          title: "Segundo hábito",
          createdAt: DateTime.now(),
        ),
      ];

      when(
        () => habitRepository.get(),
      ).thenAnswer((invocation) => Future.value(Success(habitsList)));

      final result = await insertHabitUseCase.call();

      expect(result, isA<Success<List<Habit>>>());

      final habits = (result as Success<List<Habit>>).value;

      expect(habits, habitsList);
      
    });

    test("Deve gerar um ERROR ao buscar habitos", () async {
      final habitsList = [
        Habit(
          id: "first_habit",
          title: "Primeiro hábito",
          createdAt: DateTime.now(),
        ),
        Habit(
          id: "second_habit",
          title: "Segundo hábito",
          createdAt: DateTime.now(),
        ),
      ];

      when(() => habitRepository.get()).thenAnswer(
        (invocation) =>
            Future.value(Error(Exception("Ocorreu um erro ao buscar hábitos"))),
      );

      final result = await insertHabitUseCase.call();

      expect(result, isA<Error>());
    });
  });
}
