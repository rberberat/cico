import 'package:flutter/foundation.dart';
import 'package:cico/constants/keys.dart';
import 'package:cico/modules/doge/routes.dart';
import 'package:cico/modules/home/routes.dart';
import 'package:cico/modules/more/routes.dart';
import 'package:cico/shell.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/home',
  debugLogDiagnostics: kDebugMode,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => RootShell(navigationShell: navigationShell),
      branches: [
        // Home
        StatefulShellBranch(
          routes: homeRoutes,
          initialLocation: '/home',
          navigatorKey: homeNavigatorKey,
        ),

        // Doge / Shibes
        StatefulShellBranch(
          routes: dogeRoutes,
          initialLocation: '/doge',
          navigatorKey: dogsNavigatorKey,
        ),

        // More
        StatefulShellBranch(
          routes: moreRoutes,
          initialLocation: '/more',
          navigatorKey: moreNavigatorKey,
        ),
      ],
    ),
  ],
);
