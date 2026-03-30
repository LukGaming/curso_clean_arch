import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/update_habit_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/repository_mocks.dart';

void main() {
  late HabitRepository habitRepository;
  late UpdateHabitUsecase updateHabitUseCase;

  setUp(() {
    habitRepository = MockHabitRepository();
    updateHabitUseCase = UpdateHabitUsecase(habitRepository);
  });

  group("UpdateHabitUsecase tests", () {
    test("Deve deletar os habitos corretamente", () async {
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
        () => habitRepository.update(habitsList.first),
      ).thenAnswer((invocation) => Future.value(Success(null)));

      final result = await updateHabitUseCase.call(habitsList.first);

      expect(result, isA<Success<void>>());
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

      when(() => habitRepository.update(habitsList.first)).thenAnswer(
        (invocation) => Future.value(
          Error(Exception("Ocorreu um erro ao atualizar hábitos")),
        ),
      );

      final result = await updateHabitUseCase.call(habitsList.first);

      expect(result, isA<Error>());
    });
  });
}
