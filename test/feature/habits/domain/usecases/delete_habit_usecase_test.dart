import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/domain/entities/habit.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/repository_mocks.dart';

void main() {
  late HabitRepository habitRepository;
  late DeleteHabitUsecase deleteHabitUseCase;

  setUp(() {
    habitRepository = MockHabitRepository();
    deleteHabitUseCase = DeleteHabitUsecase(habitRepository);
  });

  group("DeleteHabitUsecase tests", () {
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
        () => habitRepository.delete(habitsList.first.id),
      ).thenAnswer((invocation) => Future.value(Success(null)));

      final result = await deleteHabitUseCase.call(habitsList.first.id);

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

      when(() => habitRepository.delete(habitsList.first.id)).thenAnswer(
        (invocation) => Future.value(
          Error(Exception("Ocorreu um erro ao deletar hábitos")),
        ),
      );

      final result = await deleteHabitUseCase.call(habitsList.first.id);

      expect(result, isA<Error>());
    });
  });
}
