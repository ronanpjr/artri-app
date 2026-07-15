import 'package:artriapp/models/index.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PhysicalExerciseRoutes implements RoutesSession {
  static final String _base = ExerciseOptionsRoutes.physicalExercise;
  static String handExercises = '$_base/hand';
  static String feetExercises = '$_base/feet';
  static String customExercises = '$_base/custom';
  static String congratulations = '$_base/congratulations';

  static List<RouteBase> getGoRoutes() => [
        GoRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          path: 'congratulations',
          builder: (context, state) => CongratulationsView(),
        ),
        ShellRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state, child) => PhysicalExerciseView(
            title: 'Mãos',
            child: child,
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
          ),
          routes: [
            GoRoute(
              path: 'hand',
              builder: (context, state) => const LevelExerciseSelector(),
              routes: [
                GoRoute(
                  path: ':difficulty',
                  builder: (context, state) =>
                      const PhysicalExerciseRoutineOverview(),
                  routes: [
                    GoRoute(
                      path: ':exerciseId',
                      builder: (context, state) => ExerciseRoutineStepView(
                        key: ValueKey(state.pathParameters['exerciseId']),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state, child) => PhysicalExerciseView(
            title: 'Pés',
            child: child,
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
          ),
          routes: [
            GoRoute(
              path: 'feet',
              builder: (context, state) => const LevelExerciseSelector(),
              routes: [
                GoRoute(
                  path: ':difficulty',
                  builder: (context, state) =>
                      const PhysicalExerciseRoutineOverview(),
                  routes: [
                    GoRoute(
                      path: ':exerciseId',
                      builder: (context, state) => ExerciseRoutineStepView(
                        key: ValueKey(state.pathParameters['exerciseId']),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state, child) => PhysicalExerciseView(
            title: 'Personalizado',
            child: child,
            subtitle: DifficultyHelper.getDifficultyText(
              state.pathParameters['difficulty'],
            ),
          ),
          routes: [
            GoRoute(
              path: 'custom',
              builder: (context, state) => const LevelExerciseSelector(),
              routes: [
                GoRoute(
                  path: ':difficulty',
                  builder: (context, state) =>
                      const PhysicalExerciseRoutineOverview(),
                ),
              ],
            ),
          ],
        ),
        ShellRoute(
          parentNavigatorKey: RouterKeys.appRoutesKey,
          builder: (context, state, child) => PhysicalExerciseView(
            title: 'Personalizado',
            child: child,
          ),
          routes: [
            GoRoute(
              path: '/custom_routine/overview',
              builder: (context, state) => const CustomRoutineOverviewPage(),
              routes: [
                GoRoute(
                  path: ':exerciseId',
                  builder: (context, state) => ExerciseRoutineStepView(
                    key: ValueKey(state.pathParameters['exerciseId']),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: '/custom_routine/select',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>;
                return CategorySelectionView(
                  categoryTitle: extra['title'] as String,
                  categoryKey: extra['key'] as String,
                );
              },
            ),
            GoRoute(
              path: '/custom_routine/advanced',
              builder: (context, state) => const CustomRoutineAdvancedPage(),
            ),
          ],
        ),
      ];
}
