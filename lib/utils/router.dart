import 'package:construction/presentation/screens/auth/register.dart';
import 'package:construction/presentation/screens/dashboard.dart';
import 'package:construction/presentation/screens/estimations/estimation_page.dart';
import 'package:construction/presentation/screens/invoices/invoices_page.dart';
import 'package:construction/presentation/screens/orders/orders_page.dart';
import 'package:construction/presentation/screens/sites/site_description.dart';
import 'package:construction/presentation/screens/sites/site_page.dart';
import 'package:construction/presentation/screens/splash.dart';
import 'package:construction/presentation/screens/stocks/stock_page.dart';
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
      case site:
        return MaterialPageRoute(
            builder: (context) => const SitePage(), settings: settings);
      case siteDesc:
        return MaterialPageRoute(
            builder: (context) => const SiteDescription(), settings: settings);
      case stocks:
        return MaterialPageRoute(
            builder: (context) => const StockPage(), settings: settings);
      case orders:
        return MaterialPageRoute(
            builder: (context) => const OrderPage(), settings: settings);
      case estimation:
        return MaterialPageRoute(
            builder: (context) => const EstimationPage(), settings: settings);
      case invoices:
        return MaterialPageRoute(
            builder: (context) => const InvoicePage(), settings: settings);
    }
    return null;
  }
}
