import 'package:bot_toast/bot_toast.dart';
import 'package:construction/bloc/auth/auth_bloc.dart';
import 'package:construction/bloc/counter/counter_bloc.dart';

import 'package:construction/bloc/dropdown/dropdown_bloc.dart';
import 'package:construction/bloc/hidepassword/hidepassword_cubit.dart';
import 'package:construction/bloc/pickimage/pickimage_bloc.dart';
import 'package:construction/bloc/sites/sites_bloc.dart';

import 'package:construction/utils/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    AkarDevelopers(
      router: AppRouter(),
    ),
  );
}

class AkarDevelopers extends StatelessWidget {
  final AppRouter router;
  const AkarDevelopers({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HidepasswordCubit>(
            create: (context) => HidepasswordCubit()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
        BlocProvider<DropdownBloc>(
          create: (context) => DropdownBloc(),
        ),
        BlocProvider<SitesBloc>(create: (context) => SitesBloc()),
        BlocProvider<PickimageBloc>(create: (context) => PickimageBloc()),
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        theme: ThemeData(useMaterial3: true),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: "Akar Developers",
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
