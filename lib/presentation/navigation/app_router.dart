import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/di.dart';
import 'package:todo_app/data/local_data_source/permanent_data_source/app_cache.dart';
import 'package:todo_app/domain/usecase/usecase.dart';
import 'package:todo_app/presentation/ui/add_new_task_page/view/add_new_task_page.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';
import 'package:todo_app/presentation/ui/done_task_page/view/done_task_page.dart';
import 'package:todo_app/presentation/ui/home_page/view/home_page.dart';
import 'package:todo_app/presentation/ui/splash_page/view/splash_page.dart';

class RoutesPath {
  static const splash = "/Splash";
  static const login = "/Login";
  static const home = "/Home";
  static const addNewTask = "/AddNewTask";
  static const doneTasks = "/DoneTasks";
}

class RoutesName {
  static const splash = "Splash";
  static const login = "Login";
  static const home = "Home";
  static const addNewTask = "AddNewTask";
  static const doneTasks = "DoneTasks";
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final AppSharedPrefs _appPreferences;
  // final AppNavigationManagerImpl _appNavigationManager;
  AppRouter(this._appPreferences);

  // 4
  late final router = GoRouter(
    navigatorKey: navigatorKey,
    // 5
    debugLogDiagnostics: false,
    // 6
    // refreshListenable: _appNavigationManager,
    // 7
    initialLocation: RoutesPath.home,
    // 8
    routes: [
      //  Splash Page
      GoRoute(
        name: RoutesName.splash,
        path: RoutesPath.splash,
        builder: (context, state) => const SplashPage(),
      ),
      //  Home Page
      GoRoute(
        name: RoutesName.home,
        path: RoutesPath.home,
        builder: (context, state) => const HomePage(),
      ),
      //  Add New Task Page
      GoRoute(
        name: RoutesName.addNewTask,
        path: RoutesPath.addNewTask,
        builder: (context, state) {
          AddTodoTaskUseCase addTodoTaskUseCase =
              DI.getItInstance<AddTodoTaskUseCase>();
          return AddNewTaskPage(addTodoTaskUseCase);
        },
      ),
      GoRoute(
        name: RoutesName.doneTasks,
        path: RoutesPath.doneTasks,
        builder: (context, state) {
          final todoTasks = state.extra as Map<String, TodoTask>;
          return DoneTasksPage(todoTasks);
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },
    redirect: (ctx, goRouterState) async {
      // final loggedIn = _appPreferences.getIsUserLoggedIn();

      // final loggingIn = goRouterState.location == RoutesPath.login;

      // if (!loggedIn) return loggingIn ? null : RoutesPath.login;

      return null;
    },
  );
}
