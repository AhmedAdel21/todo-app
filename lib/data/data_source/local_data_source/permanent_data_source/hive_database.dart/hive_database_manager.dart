import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/data/data_source/local_data_source/permanent_data_source/hive_database.dart/hive_classes.dart';
import 'package:todo_app/data/data_source/local_data_source/permanent_data_source/hive_database.dart/hive_helper.dart';

abstract class HiveDataBaseManager {
  Future<void> init();
  Future<void> addTodoTask(TodoTaskHive input);
  Future<TodoTaskHive?> removeTask(String id);
  Future<TodoTaskHive?> setTaskState(String hiveTaskId, bool newState);

  Map<String, TodoTaskHive>? get getAllTodoTasks;
}

class HiveDataBaseManagerImpl implements HiveDataBaseManager {
  HiveDataBase? _dataBase;
  TodoTasksHiveWrapper? _todoTasksHiveWrapper;
  @override
  Future<void> init() async {
    _dataBase = HiveDataBaseImpl();
    await _dataBase?.initHive();
    _todoTasksHiveWrapper = await _dataBase?.getTodoTasksHiveWrapper;
  }

  @override
  Future<void> addTodoTask(TodoTaskHive input) async {
    try {
      await _todoTasksHiveWrapper!.addNewTask(input);
    } catch (e) {
      throw HiveDataBaseException(HiveDataBaseExceptionsType.dataBaseNotInt);
    }
  }

  @override
  Future<TodoTaskHive?> removeTask(String id) async {
    try {
      return await _todoTasksHiveWrapper!.removeTask(id);
    } catch (e) {
      throw HiveDataBaseException(HiveDataBaseExceptionsType.dataBaseNotInt);
    }
  }

  @override
  Future<TodoTaskHive?> setTaskState(String hiveTaskId, bool newState) async {
    try {
      return await _todoTasksHiveWrapper!.setTaskState(hiveTaskId, newState);
    } catch (e) {
      throw HiveDataBaseException(HiveDataBaseExceptionsType.dataBaseNotInt);
    }
  }

  @override
  Map<String, TodoTaskHive>? get getAllTodoTasks {
    try {
      return _todoTasksHiveWrapper?.todoTask;
    } catch (e) {
      throw HiveDataBaseException(HiveDataBaseExceptionsType.dataBaseNotInt);
    }
  }
}

abstract class HiveDataBase {
  Future<void> initHive();
  Future<TodoTasksHiveWrapper> get getTodoTasksHiveWrapper;
}

class HiveDataBaseImpl implements HiveDataBase {
  LazyBox? dataBaseBox;
  HiveDataBaseImpl();

  @override
  Future<void> initHive() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getTemporaryDirectory();
    }
    Hive
      ..init(directory?.path)
      ..registerAdapter<TodoTaskHive>(TodoTaskHiveAdapter())
      ..registerAdapter<TodoTasksHiveWrapper>(TodoTasksHiveWrapperAdapter());
    dataBaseBox = await Hive.openLazyBox(HiveBoxes.dataBaseBox);
  }

  @override
  Future<TodoTasksHiveWrapper> get getTodoTasksHiveWrapper async {
    // if (dataBaseBox == null) throw error
    final todoTask = await dataBaseBox?.get(HiveBoxes.todoTaskHiveManager)
        as TodoTasksHiveWrapper?;
    if (todoTask == null) {
      final newAdapter = TodoTasksHiveWrapper();
      await dataBaseBox?.put(HiveBoxes.todoTaskHiveManager, newAdapter);
      return newAdapter;
    } else {
      return todoTask;
    }
  }
}

class HiveBoxes {
  static const dataBaseBox = "dataBaseBox";
  static const todoTaskHiveManager = "todoTaskHiveManager";
}
