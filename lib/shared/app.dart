import 'package:base_flutter/shared/blocs/internet_connection/internet_connection_cubit.dart';
import 'package:base_flutter/shared/utilities/routers/router.imports.gr.dart';
import 'package:base_flutter/shared/utilities/utils_functions/utils.imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tf_validator/localization/SetLocalization.dart';

import 'blocs/lang_cubit/lang_cubit.dart';
import 'utilities/main_data/main_data.imports.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    Utils.manipulateSplashData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainData.providers(context),
      child: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
        builder: (context, state) {
          return BlocBuilder<LangCubit, LangState>(
            builder: (context, state) {
              return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: MainData.lightTheme,
                  themeMode: ThemeMode.light,
                  title: 'Demo',
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('ar', 'SA'),
                  ],
                  localizationsDelegates: [
                    SetLocalization.localizationsDelegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  locale: state.locale,
                  routerDelegate: _appRouter.delegate(initialRoutes: [const HomeScreenRoute()]),
                  routeInformationParser: _appRouter.defaultRouteParser(),
                  builder: (ctx, child) {
                    child = FlutterEasyLoading(child: child); //do something
                    return child;
                  });
            },
          );
        },
      ),
    );
  }
}
