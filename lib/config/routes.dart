import 'package:go_router/go_router.dart';
import 'package:simple_app_bt_uni/presentation/pages/alphabet_steps_page.dart';
import 'package:simple_app_bt_uni/presentation/pages/connect_page.dart';
import 'package:simple_app_bt_uni/presentation/pages/home_page.dart';
import 'package:simple_app_bt_uni/presentation/pages/init_page.dart';
import 'package:simple_app_bt_uni/presentation/pages/list_books_page.dart';

final appRouter = GoRouter(
  initialLocation: '/auth/connect',
  routes: [
    GoRoute(
      path: '/aphabet_steps',
      name: AlphabetStepsPage.name,
      builder: (context, state) => const AlphabetStepsPage(),
    ),
    GoRoute(
      path: '/list_books',
      name: ListBooksPage.name,
      builder: (context, state) => const ListBooksPage(),
    ),
    GoRoute(
      path: '/',
      name: InitPage.name,
      builder: (context, state) => const InitPage(),
    ),
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
