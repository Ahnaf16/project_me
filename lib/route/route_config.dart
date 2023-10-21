import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_me/feature/my_self/view/myself_view.dart';
import 'package:project_me/feature/navigation/view/nav_view.dart';
import 'package:project_me/feature/projects/view/project_view.dart';

import 'page/splash_view.dart';
import 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

final routesProvider = Provider.autoDispose<GoRouter>((ref) {
  final routeList = ref.watch(routes);
  final router = GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: RouteNames.mySelf.path,
    routes: routeList,
  );

  return router;
});

final routes = Provider<List<RouteBase>>(
  (ref) => [
    GoRoute(
      path: RouteNames.splash.path,
      name: RouteNames.splash.name,
      builder: (context, state) => const SplashView(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigator,
      builder: (context, state, child) => NavView(child),
      routes: [
        GoRoute(
          path: RouteNames.mySelf.path,
          name: RouteNames.mySelf.name,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const MySelfView(),
            transitionsBuilder: (_, animation, __, child) =>
                _kTransition(_, animation, __, child, -1.0),
          ),
        ),
        GoRoute(
          path: RouteNames.projects.path,
          name: RouteNames.projects.name,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const ProjectView(),
            transitionsBuilder: (_, animation, __, child) =>
                _kTransition(_, animation, __, child, 1.0),
          ),
        ),
      ],
    ),
  ],
);

Widget _kTransition(context, animation, secondaryAnimation, child, double dx) {
  final begin = Offset(dx, 0.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}
