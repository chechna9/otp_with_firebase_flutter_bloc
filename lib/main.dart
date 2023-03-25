import 'package:flutter/material.dart';
import 'package:mob_auth_fire_base/presentation/router/app_router.dart';

void main() async {
  // loading env

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
