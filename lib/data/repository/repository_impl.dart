import 'package:todo_app/app/di.dart';
import 'package:todo_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:todo_app/data/data_source/local_data_source/local_data_source_model.dart';
import 'package:todo_app/data/data_source/local_data_source/permanent_data_source/app_cache.dart';
import 'package:todo_app/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:todo_app/data/mapper/mapper.dart';
import 'package:todo_app/data/network/error_handler.dart';
import 'package:todo_app/data/network/network_info.dart';
import 'package:todo_app/data/requests.dart';
import 'package:todo_app/app/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/data/response/responses.dart';
import 'package:todo_app/domain/model/models.dart';
import 'package:todo_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(
      this._localDataSource, this._remoteDataSource, this._networkInfo);

  @override
  Future<void> initRepo() async {
    await _localDataSource.initLocalDataSource();
  }

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        AuthenticationResponse response =
            await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          // success -- return either right, data
          final authenticationData = response.toDomain;

          DI.getItInstance<AppSharedPrefs>().setIsUserLoggedIn(true);
          DI
              .getItInstance<AppSharedPrefs>()
              .setUserName(authenticationData.userName);
          DI
              .getItInstance<AppSharedPrefs>()
              .setPassword(authenticationData.password);

          return Right(authenticationData);
        } else {
          // failure  -- return either left, business error
          return Left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.none));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // failure -- return either left, internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addTodoTask(
      TodoTaskRequestObject request) async {
    try {
      final id = await _localDataSource.addTodoTask(
        TodoTaskLocalSourceInput(
            icon: request.icon,
            name: request.name,
            description: request.description,
            dateTime: request.dateTime,
            timeOfDay: request.timeOfDay),
      );
      return Right(id);
    } on LocalDataExceptionsType catch (e) {
      return Left(Failure(
          RepositoryErrorCodesConstant.localDataSourceErrorCode, e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, TodoTask>>> getAllTodoTasks() async {
    try {
      final allTodoTasks = await _localDataSource.getAllTodoTasks();
      Map<String, TodoTask> returnList = {};
      if (allTodoTasks == null) {
        return Right(returnList);
      }

      allTodoTasks.forEach((id, todoTaskHive) {
        returnList.addAll({id: todoTaskHive.toDomain});
      });

      return Right(returnList);
    } on LocalDataExceptionsType catch (e) {
      return Left(Failure(
          RepositoryErrorCodesConstant.localDataSourceErrorCode, e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, TodoTask>>> updateTodoTasks(
      Map<String, TodoTaskRequestObject> todoTasksToUpdate) async {
    try {
      final updatedTodoTasks = await _localDataSource.updateTodoTasks(
          todoTasksToUpdate.map((key, value) =>
              MapEntry<String, TodoTaskLocalSourceInput>(
                  key,
                  TodoTaskLocalSourceInput(
                      icon: value.icon,
                      name: value.name,
                      description: value.description,
                      dateTime: value.dateTime,
                      timeOfDay: value.timeOfDay,
                      isDone: value.isDone))));

      Map<String, TodoTask> returnList = {};

      updatedTodoTasks.forEach((id, todoTaskHive) {
        returnList.addAll({id: todoTaskHive.toDomain});
      });

      return Right(returnList);
    } on LocalDataExceptionsType catch (e) {
      return Left(Failure(
          RepositoryErrorCodesConstant.localDataSourceErrorCode, e.message));
    }
  }
}

class RepositoryErrorCodesConstant {
  static const localDataSourceErrorCode = 5000;
}
