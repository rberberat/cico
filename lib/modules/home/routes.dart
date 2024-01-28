import 'package:cico/modules/global/routes.dart';
import 'package:cico/modules/home/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final homeRoutes = [
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
    routes: [...globalRoutes],
  ),
];
