import 'package:flutter/material.dart';
import 'package:mob_auth_fire_base/presentation/screens/Sign_up.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SignUp(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
