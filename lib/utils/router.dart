import 'package:construction/presentation/screens/auth/register.dart';
import 'package:construction/presentation/screens/dashboard.dart';
import 'package:construction/presentation/screens/estimations/estimation_page.dart';
import 'package:construction/presentation/screens/invoices/invoices_page.dart';
import 'package:construction/presentation/screens/orders/orders_page.dart';
import 'package:construction/presentation/screens/sites/add_site.dart';
import 'package:construction/presentation/screens/sites/site_description.dart';
import 'package:construction/presentation/screens/sites/site_estimation.dart';
import 'package:construction/presentation/screens/sites/site_page.dart';
import 'package:construction/presentation/screens/stocks/site_stocks.dart';
import 'package:construction/presentation/screens/splash.dart';
import 'package:construction/presentation/screens/stocks/stock_report.dart';

import 'package:construction/presentation/screens/users/users_page.dart';
import 'package:construction/presentation/screens/workinprogress/edit_work_page.dart';
import 'package:construction/presentation/screens/workinprogress/report_preview.dart';
import 'package:construction/presentation/screens/workinprogress/schedule_work.dart';

import 'package:construction/presentation/screens/workinprogress/workprogress_page.dart';
import 'package:construction/presentation/settings.dart';
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
      case siteStocks:
        return MaterialPageRoute(
            builder: (context) => const SiteStocks(), settings: settings);
      case orders:
        return MaterialPageRoute(
            builder: (context) => const OrderPage(), settings: settings);
      case estimation:
        return MaterialPageRoute(
            builder: (context) => const EstimationPage(), settings: settings);
      case invoices:
        return MaterialPageRoute(
            builder: (context) => const InvoicePage(), settings: settings);
      case settingspage:
        return MaterialPageRoute(
            builder: (context) => const SettingsPage(), settings: settings);

      case siteEstimation:
        return MaterialPageRoute(
            builder: (context) => const SiteEstimation(), settings: settings);
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
      case stocksreport:
        return MaterialPageRoute(
            builder: (context) => const StockReportPreview(),
            settings: settings);
      case workreportPdf:
        return MaterialPageRoute(
            builder: (context) => const PdfReportPreviewPage(),
            settings: settings);
    }
    return null;
  }
}
