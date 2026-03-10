import 'package:curso_clean_arch/feature/habits/data/datasources/habit_local_datasource.dart';
import 'package:curso_clean_arch/feature/habits/data/datasources/habit_local_datasource_impl.dart';
import 'package:curso_clean_arch/feature/habits/data/repositories/habit_repository_impl.dart';
import 'package:curso_clean_arch/feature/habits/domain/repositories/habit_repository.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/get_habits_usecase.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/insert_habit_usecase.dart';
import 'package:curso_clean_arch/feature/habits/domain/usecases/update_habit_usecase.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/habits_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<HabitLocalDatasource>(
    () => HabitLocalDatasourceImpl(),
  );

  sl.registerLazySingleton<HabitRepository>(() => HabitRepositoryImpl(sl()));

  sl.registerLazySingleton(() => DeleteHabitUsecase(sl()));
  sl.registerLazySingleton(() => GetHabitsUsecase(sl()));
  sl.registerLazySingleton(() => InsertHabitUseCase(sl()));
  sl.registerLazySingleton(() => UpdateHabitUsecase(sl()));

  sl.registerLazySingleton(() => HabitsCubit(sl(), sl(), sl(), sl()));

}
