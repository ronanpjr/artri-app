import 'package:artriapp/models/myth.dart';
import 'package:artriapp/models/route_session.dart';
import 'package:artriapp/routes/index.dart';
import 'package:artriapp/utils/router_keys.dart';
import 'package:go_router/go_router.dart';
import 'package:artriapp/views/info/index.dart';

class InfoRoutes implements RoutesSession {
  static final String _base = BottomNavRoutes.info;
  static String artriteInfoPage = '$_base/artrite';
  static String treatmentsInfoPage = '$_base/treatments';
  static String myPainInfoPage = '$_base/my-pain';
  static String sleepInfoPage = '$_base/sleep';
  static String foodRoutineInfoPage = '$_base/food-routine';
  static String lawsInfoPage = '$_base/laws';
  static String emotionalPage = '$_base/emotional';
  static String exercisesInfoPage = '$_base/exercises';
  static String mythsTruthsInfoPage = '$_base/myths-truths';

  static List<RouteBase> getGoRoutes() {
    return [
      GoRoute(
        parentNavigatorKey: RouterKeys.appRoutesKey,
        path: 'artrite',
        builder: (context, state) => const ArtriteInfoPage(),
      ),
      GoRoute(
        parentNavigatorKey: RouterKeys.appRoutesKey,
        path: 'treatments',
        builder: (context, state) => const TratamentosInfoPage(),
      ),
      GoRoute(
        parentNavigatorKey: RouterKeys.appRoutesKey,
        path: 'my-pain',
        builder: (context, state) => const MinhaDorInfoPage(),
      ),
      GoRoute(
        parentNavigatorKey: RouterKeys.appRoutesKey,
        path: 'sleep',
        builder: (context, state) => const SonoInfoPage(),
      ),
      GoRoute(
        parentNavigatorKey: RouterKeys.appRoutesKey,
        path: 'food-routine',
        builder: (context, state) => const AlimentacaoInfoPage(),
      ),
      GoRoute(
        parentNavigatorKey: RouterKeys.appRoutesKey,
        path: 'emotional',
        builder: (context, state) => const EmocionalInfoPage(),
      ),
      GoRoute(
        parentNavigatorKey: RouterKeys.appRoutesKey,
        path: 'exercises',
        builder: (context, state) => const ExercicioInfoPage(),
      ),
      GoRoute(
        parentNavigatorKey: RouterKeys.appRoutesKey,
        path: 'laws',
        builder: (context, state) => const LeisDireitosInfoPage(),
      ),
      GoRoute(
        parentNavigatorKey: RouterKeys.appRoutesKey,
        path: 'myths-truths',
        builder: (context, state) {
          final myth = state.extra as Myth?;

          return MitosVerdadesInfoPage(
            highlightedMyth: myth,
          );
        },
      ),
    ];
  }
}
