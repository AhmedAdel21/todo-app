import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';
import 'package:todo_app/presentation/ui/common/base_viewmodel/base_viewmodel.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';

class DoneTasksPageViewModel extends BaseViewModel
    with ChangeNotifier
    implements _DoneTasksPageViewModelInputs, _DoneTasksPageViewModelOutputs {
  final Map<String, TodoTask> _allTodoTaskMap;
  final Map<String, TodoTask> _doneTasks = {};
  DoneTasksPageViewModel(this._allTodoTaskMap);

  final StreamController<DataState> _dataStateSC =
      StreamController<DataState>();

  DateTime selectedDay = DateTime.now();
  @override
  void destroy() {
    _dataStateSC.close();
  }

  @override
  void start() {
    _dataStateSC.add(DataState.loading);
    _allTodoTaskMap.forEach((key, value) {
      if (value.isDone) {
        _doneTasks.addAll({key: value});
      }
    });
    if (_doneTasks.isNotEmpty) {
      _dataStateSC.add(DataState.data);
    } else {
      _dataStateSC.add(DataState.empty);
    }
  }

  @override
  Map<String, TodoTask> get getTodoTasks => _doneTasks;

  @override
  Stream<DataState> get onDataStateChanged => _dataStateSC.stream;

  @override
  String get getTitle => AppStrings.doneTasks;
}

abstract class _DoneTasksPageViewModelInputs {}

abstract class _DoneTasksPageViewModelOutputs {
  Stream<DataState> get onDataStateChanged;
  Map<String, TodoTask> get getTodoTasks;

  String get getTitle;
}

