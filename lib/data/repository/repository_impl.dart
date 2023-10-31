import 'package:todo_app/data/local_data_source/local_data_source.dart';
import 'package:todo_app/data/local_data_source/local_data_source_model.dart';
import 'package:todo_app/data/mapper/mapper.dart';
import 'package:todo_app/data/requests.dart';
import 'package:todo_app/app/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/repository/repository.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;
  RepositoryImpl(this._localDataSource);

  @override
  Future<void> initRepo() async {
    await _localDataSource.initLocalDataSource();
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
