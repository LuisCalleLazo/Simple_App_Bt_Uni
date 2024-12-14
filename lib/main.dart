import 'package:flutter/material.dart';
import 'package:simple_app_bt_uni/config/routes.dart';
import 'package:simple_app_bt_uni/config/theme.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
