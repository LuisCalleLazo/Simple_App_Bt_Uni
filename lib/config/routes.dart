import 'package:go_router/go_router.dart';
import 'package:simple_app_bt_uni/presentation/pages/connect_page.dart';
import 'package:simple_app_bt_uni/presentation/pages/home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/auth/connect',
  routes: [
    GoRoute(
      path: '/auth/connect',
      name: ConnectPage.name,
      builder: (context, state) => const ConnectPage(),
    ),
    GoRoute(
      path: '/home',
      name: HomePage.name,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
