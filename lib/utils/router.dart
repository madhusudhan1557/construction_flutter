import 'package:construction/presentation/screens/splash.dart';
import 'package:construction/utils/routes.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/auth/login.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
    return null;
  }
}
