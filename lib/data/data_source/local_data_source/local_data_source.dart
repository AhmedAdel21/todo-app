import 'package:todo_app/data/data_source/local_data_source/local_data_source_model.dart';
import 'package:todo_app/data/data_source/local_data_source/permanent_data_source/hive_database.dart/hive_classes.dart';
import 'package:todo_app/data/data_source/local_data_source/permanent_data_source/hive_database.dart/hive_helper.dart';

import 'permanent_data_source/hive_database.dart/hive_database_manager.dart';

abstract class LocalDataSource {
  Future<void> initLocalDataSource();
  Future<int> addTodoTask(TodoTaskLocalSourceInput input);
  Future<Map<String, TodoTaskHive>?> getAllTodoTasks();
  Future<Map<String, TodoTaskHive>> updateTodoTasks(
      Map<String, TodoTaskLocalSourceInput> todoTasksToUpdate);
}

class LocalDataSourceImpl implements LocalDataSource {
  HiveDataBaseManager? _hiveDataBaseManager;

  @override
  Future<void> initLocalDataSource() async {
    _hiveDataBaseManager = HiveDataBaseManagerImpl();
    await _hiveDataBaseManager?.init();
  }

  @override
  Future<int> addTodoTask(TodoTaskLocalSourceInput input) async {
    try {
      int id = DateTime.now().millisecondsSinceEpoch.toSigned(32);
      await _hiveDataBaseManager!.addTodoTask(TodoTaskHive(
          id: id.toString(),
          icon: input.icon,
          name: input.name,
          description: input.description,
          dateTime: input.dateTime,
          isDone: input.isDone,
          hour: input.timeOfDay.hour,
          minute: input.timeOfDay.minute));
      return id;
    } on HiveDataBaseException catch (e) {
      throw _hiveDataBaseErrorHandler(e);
    }
  }

  @override
  Future<Map<String, TodoTaskHive>> updateTodoTasks(
      Map<String, TodoTaskLocalSourceInput> todoTasksToUpdate) async {
    Map<String, TodoTaskHive> returnedMap = {};
    try {
      for (var todoTask in todoTasksToUpdate.entries) {
        final key = todoTask.key;
        final todoTaskData = todoTask.value;
        final updatedTask =
            await _hiveDataBaseManager!.setTaskState(key, todoTaskData.isDone);
        if (updatedTask != null) {
          returnedMap.addAll({updatedTask.id: updatedTask});
        }
      }
      return returnedMap;
    } catch (e) {
      return {};
    }
  }

  @override
  Future<Map<String, TodoTaskHive>?> getAllTodoTasks() async {
    try {
      return _hiveDataBaseManager!.getAllTodoTasks;
    } on HiveDataBaseException catch (e) {
      throw _hiveDataBaseErrorHandler(e);
    }
  }

  LocalDataExceptionsType _hiveDataBaseErrorHandler(HiveDataBaseException e) {
    switch (e.message) {
      case HiveDataBaseExceptionsType.dataBaseNotInt:
        return LocalDataExceptionsType.dataBaseNotInt;
      case HiveDataBaseExceptionsType.none:
        return LocalDataExceptionsType.none;
    }
  }
}

enum LocalDataExceptionsType {
  dataBaseNotInt("Data base not init yet"),
  none("");

  final String message;
  const LocalDataExceptionsType(this.message);
}

class LocalDataException implements Exception {
  final LocalDataExceptionsType message;
  LocalDataException([this.message = LocalDataExceptionsType.none]);

  @override
  String toString() => "LocalDataException: ${message.message}";
}
