import 'package:curso_clean_arch/core/routes/routes.dart';
import 'package:curso_clean_arch/feature/habits/presentation/pages/habits_page.dart';
import 'package:curso_clean_arch/feature/habits/presentation/pages/new_habit_form_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.habits,
  routes: [
    GoRoute(
      path: AppRoutes.habits,
      builder: (context, state) => const HabitsPage(),
    ),
    GoRoute(
      path: AppRoutes.createHabit,
      builder: (context, state) => NewHabitFormPage(),
    ),
  ],
);
