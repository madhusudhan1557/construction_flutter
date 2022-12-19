import 'package:construction/presentation/screens/auth/register.dart';
import 'package:construction/presentation/screens/bottom_navbar.dart';

import 'package:construction/presentation/screens/orders/order_signature_page.dart';

import 'package:construction/presentation/screens/sites/add_site.dart';
import 'package:construction/presentation/screens/sites/site_description.dart';

import 'package:construction/presentation/screens/sites/site_page.dart';
import 'package:construction/presentation/screens/stocks/site_stocks.dart';
import 'package:construction/presentation/screens/splash.dart';
import 'package:construction/presentation/screens/stocks/stocks_signature_page.dart';

import 'package:construction/presentation/screens/users/users_page.dart';
import 'package:construction/presentation/screens/workinprogress/edit_work_page.dart';
import 'package:construction/presentation/screens/workinprogress/schedule_work.dart';
import 'package:construction/presentation/screens/workinprogress/work_report_signature_pad.dart';

import 'package:construction/presentation/screens/workinprogress/workprogress_page.dart';
import 'package:construction/presentation/settings.dart';
import 'package:construction/utils/routes.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/auth/login.dart';
import '../presentation/screens/orders/site_order.dart';

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
      case navscreen:
        return MaterialPageRoute(builder: (context) => const BottomNavBar());
      case site:
        return MaterialPageRoute(
            builder: (context) => const SitePage(), settings: settings);
      case siteDesc:
        return MaterialPageRoute(
            builder: (context) => const SiteDescription(), settings: settings);
      case siteStocks:
        return MaterialPageRoute(
            builder: (context) => const SiteStocks(), settings: settings);
      case orders:
        return MaterialPageRoute(
            builder: (context) => const OrderPage(), settings: settings);

      case settingspage:
        return MaterialPageRoute(
            builder: (context) => const SettingsPage(), settings: settings);
      case orderInvoiceSignaturePadPage:
        return MaterialPageRoute(
            builder: (context) => const OrderInvoiceSignaturePadPage(),
            settings: settings);
      case workinprogress:
        return MaterialPageRoute(
            builder: (context) => const WorkInProgressPage(),
            settings: settings);
      case scheduleWOrk:
        return MaterialPageRoute(
            builder: (context) => const ScheduleWork(), settings: settings);
      case userspage:
        return MaterialPageRoute(
            builder: (context) => const UsersPage(), settings: settings);
      case editwork:
        return MaterialPageRoute(
            builder: (context) => const EditWorkPage(), settings: settings);
      case addsitepage:
        return MaterialPageRoute(
            builder: (context) => const AddSitePage(), settings: settings);
      case stockSignaturePadPage:
        return MaterialPageRoute(
            builder: (context) => const StockReportSignaturePadPage(),
            settings: settings);
      case workInvoiceSignaturePadPage:
        return MaterialPageRoute(
            builder: (context) => const WorkReportSignaturePadPage(),
            settings: settings);
    }
    return null;
  }
}
