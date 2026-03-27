import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/insert_habit_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/repository_mocks.dart';

void main() {
  late HabitRepository habitRepository;
  late InsertHabitUseCase insertHabitUseCase;

  setUp(() {
    habitRepository = MockHabitRepository();
    insertHabitUseCase = InsertHabitUseCase(habitRepository);
  });

  group("InsertHabitUseCase tests", () {
    test('Deve criar hábito com sucesso', () async {
      final habitToCreate = Habit(
        id: "first_habit",
        title: "Primeiro hábito",
        createdAt: DateTime.now(),
      );

      when(
        () => habitRepository.insert(habitToCreate),
      ).thenAnswer((invocation) => Future.value(Success(null)));

      final result = await insertHabitUseCase.call(habitToCreate);

      expect(result, isA<Success>());
    });

    test("Deve gerar erro ao criar hábito", () async {
      final habitToCreate = Habit(
        id: "first_habit",
        title: "Primeiro hábito",
        createdAt: DateTime.now(),
      );

      when(() => habitRepository.insert(habitToCreate)).thenAnswer(
        (invocation) =>
            Future.value(Error(Exception("Ocorreu um erro ao criar hábito"))),
      );

      final result = await insertHabitUseCase.call(habitToCreate);

      expect(result, isA<Error>());
    });
  });
}
