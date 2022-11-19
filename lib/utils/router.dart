import 'package:construction/presentation/screens/auth/register.dart';
import 'package:construction/presentation/screens/dashboard.dart';
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
      case register:
        return MaterialPageRoute(
            builder: (context) => const RegistrationScreen());
      case dashboard:
        return MaterialPageRoute(builder: (context) => const Dashboard());
    }
    return null;
  }
}
