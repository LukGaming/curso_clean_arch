import 'package:curso_clean_arch/core/result/result.dart';
import 'package:curso_clean_arch/feature/habits/data/datasources/habit_local_datasource.dart';
import 'package:curso_clean_arch/feature/habits/data/models/habit_model.dart';
import 'package:curso_clean_arch/feature/habits/data/repositories/habit_repository_impl.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/get_habits_usecase.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/insert_habit_usecase.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/update_habit_usecase.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/habits_cubit.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/habits_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/datasource_mocks.dart';

void main() {
  late HabitsCubit habitsCubit;
  late InsertHabitUseCase insertHabitUseCase;
  late GetHabitsUsecase getHabitsUsecase;
  late DeleteHabitUsecase deleteHabitUsecase;
  late UpdateHabitUsecase updateHabitUsecase;
  late HabitRepository habitRepository;
  late HabitLocalDatasource habitLocalDatasource;

  setUpAll(() {
    habitLocalDatasource = MockHabitsDataSource();
    habitRepository = HabitRepositoryImpl(habitLocalDatasource);
    insertHabitUseCase = InsertHabitUseCase(habitRepository);
    getHabitsUsecase = GetHabitsUsecase(habitRepository);
    deleteHabitUsecase = DeleteHabitUsecase(habitRepository);
    updateHabitUsecase = UpdateHabitUsecase(habitRepository);
    habitsCubit = HabitsCubit(
      getHabitsUsecase,
      insertHabitUseCase,
      updateHabitUsecase,
      deleteHabitUsecase,
    );
  });

  test('HabitsCubit initial state', () async {
    expect(habitsCubit.state, isA<HabitsInitial>());
  });

  test("Should emit HabitsLoaded", () async {
    final habitsModel = [
      HabitModel(
        id: "first_habit",
        title: "First Habit",
        createdAt: DateTime.now(),
      ),
      HabitModel(
        id: "second_habit",
        title: "Second Habit",
        createdAt: DateTime.now(),
      ),
    ];

    when(
      () => habitLocalDatasource.getHabits(),
    ).thenAnswer((invocation) => Future.value(Success(habitsModel)));

    await habitsCubit.getHabits();

    expect(habitsCubit.state, isA<HabitsLoaded>());

    final habits = (habitsCubit.state as HabitsLoaded).habits;

    expect(habits.length, 2);
  });
}
