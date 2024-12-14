import 'package:go_router/go_router.dart';
import 'package:simple_app_bt_uni/presentation/pages/home_page.dart';
import 'package:simple_app_bt_uni/presentation/pages/login_page.dart';

final appRouter = GoRouter(
  initialLocation: '/auth/login',
  routes: [
    GoRoute(
      path: '/auth/login',
      name: LoginPage.name,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      name: HomePage.name,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
