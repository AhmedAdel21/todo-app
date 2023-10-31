import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app/app/di.dart';
import 'package:todo_app/data/local_data_source/permanent_data_source/app_cache.dart';
import 'package:todo_app/presentation/navigation/app_router.dart';

class MyApp extends StatefulWidget {
  // named constructor
  const MyApp._internal(); // to use singleton pattern to instantiate the class just one time and no one outside of the class can use the default constructor

  static const MyApp _instant = MyApp._internal();

  factory MyApp() => _instant;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppSharedPrefs _appCache = DI.getItInstance<AppSharedPrefs>();
  late final _appRouter = AppRouter(_appCache);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final router = _appRouter.router;
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      // theme: getApplicationTheme(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
