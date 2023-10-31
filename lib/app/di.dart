import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:todo_app/data/data_source/local_data_source/permanent_data_source/app_cache.dart';
import 'package:todo_app/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:todo_app/data/managers/notification_plugin_manager_impl.dart';
import 'package:todo_app/data/network/dio_factory.dart';
import 'package:todo_app/data/network/network_info.dart';
import 'package:todo_app/data/network/rest_api/app_api.dart';
import 'package:todo_app/data/repository/repository_impl.dart';
import 'package:todo_app/domain/managers/notification_manager.dart';
import 'package:todo_app/domain/managers/notification_plugin_manager.dart';
import 'package:todo_app/domain/repository/repository.dart';
import 'package:todo_app/domain/usecase/login_usecase.dart';
import 'package:todo_app/presentation/navigation/app_navigation_manager.dart';

import '../domain/usecase/usecase.dart';

class DI {
  static final _instance = GetIt.instance;

  static GetIt get getItInstance => _instance;
  static Future<void> initAppModule() async {
    // shared prefs _instance
    final sharedPrefs = await SharedPreferences.getInstance();
    _instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

    // app prefs
    _instance.registerLazySingleton<AppSharedPrefs>(
        () => AppSharedPrefsImpl(_instance()));

    // network info
    _instance.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(InternetConnectionChecker()));

    // LocalDataSource
    _instance
        .registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

    // dio factory
    _instance.registerLazySingleton<DioFactory>(() => DioFactory(_instance()));

    // app service client
    final dio = await _instance<DioFactory>().getDio;
    _instance
        .registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

    _instance.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(_instance()));

    // init repo
    _instance.registerLazySingleton<Repository>(
        () => RepositoryImpl(_instance(), _instance(), _instance()));
    await _instance<Repository>().initRepo();

    _initUseCases();

    // App Notification Manager

    _instance.registerLazySingleton<NotificationPluginManager>(
        () => NotificationPluginManagerImpl());
    _instance.registerLazySingleton<NotificationManager>(
        () => NotificationManagerImpl(_instance()));
    await _instance<NotificationManager>().init();

    // App Navigation Manager
    _instance.registerLazySingleton<AppNavigationManager>(
        () => AppNavigationManagerImpl());
  }

  static void _initUseCases() {
    _instance.registerLazySingleton<AddTodoTaskUseCase>(
        () => AddTodoTaskUseCase(_instance()));
    _instance.registerLazySingleton<GetAllTodoTasksUseCase>(
        () => GetAllTodoTasksUseCase(_instance()));
    _instance.registerLazySingleton<UpdateTodoTasksUseCase>(
        () => UpdateTodoTasksUseCase(_instance()));
    _instance
        .registerLazySingleton<LoginUseCase>(() => LoginUseCase(_instance()));
  }
}
