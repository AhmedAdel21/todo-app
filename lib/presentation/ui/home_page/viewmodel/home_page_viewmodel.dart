import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:todo_app/app/di.dart';
import 'package:todo_app/app/extensions.dart';
import 'package:todo_app/domain/model/models.dart';
import 'package:todo_app/domain/usecase/usecase.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';
import 'package:todo_app/presentation/ui/add_new_task_page/view/add_new_task_page.dart';
import 'package:todo_app/presentation/ui/common/base_viewmodel/base_viewmodel.dart';
import 'package:todo_app/presentation/ui/common/table_calendar/src_code/shared/utils.dart';
import 'package:todo_app/presentation/ui/common/toast/toast.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';

class HomePageViewModel extends BaseViewModel
    with ChangeNotifier
    implements _HomePageViewModelInputs, _HomePageViewModelOutputs {
  Map<String, TodoTask> _todoTaskMap = {};
  Map<DateTime, List<TodoTask>> _todoTaskDayToTasksMap = {};

  final StreamController<DataState> _dataStateSC =
      StreamController<DataState>();

  TodoTaskCardMode todoTaskCardMode = TodoTaskCardMode.normal;
  HomePageViewMode homePageViewMode = HomePageViewMode.list;

  DateTime selectedDay = DateTime.now();
  @override
  void destroy() {
    _dataStateSC.close();
  }

  @override
  void start() {
    _dataStateSC.add(DataState.loading);
    _getAllTodoTasks();
  }

  void _getAllTodoTasks() async {
    (await DI.getItInstance<GetAllTodoTasksUseCase>().execute(null)).fold(
        (left) {
      ToastManager.showTextToast(
          "${AppStrings.failedToGetTodoTasks}[${left.message}]");
      _dataStateSC.add(DataState.error);
    }, (right) {
      _todoTaskMap = right;
      _todoTaskDayToTasksMap = _getTodoTaskDayToTasksMap(right);
      if (_todoTaskMap.isEmpty) {
        _dataStateSC.add(DataState.empty);
      } else {
        _dataStateSC.add(DataState.data);
      }
    });
  }

  Map<DateTime, List<TodoTask>> _getTodoTaskDayToTasksMap(
      Map<String, TodoTask> tasksMap) {
    Map<DateTime, List<TodoTask>> returnMap = {};
    for (var task in tasksMap.values) {
      final dayKey =
          DateTime(task.dateTime.year, task.dateTime.month, task.dateTime.day);

      if (returnMap.containsKey(dayKey)) {
        returnMap[dayKey]!.add(task);
      } else {
        returnMap.addAll({
          dayKey: [task]
        });
      }
    }

    return returnMap;
  }

  @override
  Map<String, TodoTask> get getTodoTasks {
    switch (homePageViewMode) {
      case HomePageViewMode.list:
        return _todoTaskMap;

      case HomePageViewMode.calender:
        Map<String, TodoTask> returnList = {};
        _todoTaskMap.forEach((id, todoTask) {
          if (isSameDay(selectedDay, todoTask.dateTime)) {
            returnList.addAll({id: todoTask});
          }
        });
        return returnList;
    }
  }

  @override
  void goToAddNewTaskPage(BuildContext ctx, double width) async {
    AddTodoTaskUseCase addTodoTaskUseCase =
        DI.getItInstance<AddTodoTaskUseCase>();

    await SideSheet.right(
        width: width * 0.9,
        body: AddNewTaskPage(addTodoTaskUseCase),
        context: ctx);

    _dataStateSC.add(DataState.loading);
    _getAllTodoTasks();
  }

  @override
  Stream<DataState> get onDataStateChanged => _dataStateSC.stream;

  @override
  void toggleTodoTaskCardMode() {
    switch (todoTaskCardMode) {
      case TodoTaskCardMode.normal:
        todoTaskCardMode = TodoTaskCardMode.selectable;
        break;
      case TodoTaskCardMode.selectable:
        todoTaskCardMode = TodoTaskCardMode.normal;
        break;
    }
    notifyListeners();
  }

  Map<String, TodoTask> _changedTasks = {};

  @override
  void toggleCaredSelection(String id) {
    final targetTask = _todoTaskMap[id]!;
    _changedTasks[id] = targetTask.copyWith(isDone: targetTask.isDone.toggle());
  }

  @override
  void acceptAllChanges() {
    _updateTodoTasks();

    toggleTodoTaskCardMode();
  }

  void _updateTodoTasks() async {
    _dataStateSC.add(DataState.loading);
    (await DI.getItInstance<UpdateTodoTasksUseCase>().execute(_changedTasks))
        .fold((left) {
      ToastManager.showTextToast(
          "${AppStrings.failedToGetTodoTasks}[${left.message}]");
      _changedTasks = {};
    }, (right) {
      if (right.isEmpty) {
        ToastManager.showTextToast(AppStrings.noTaskWasUpdated);
      } else {
        ToastManager.showTextToast(AppStrings.updatedSuccessfully);
      }
      right.forEach((key, value) {
        _todoTaskMap[key] = value;
      });
      _todoTaskDayToTasksMap = _getTodoTaskDayToTasksMap(_todoTaskMap);
      if (_todoTaskMap.isEmpty) {
        _dataStateSC.add(DataState.empty);
      } else {
        _dataStateSC.add(DataState.data);
      }
      _changedTasks = {};
    });
  }

  @override
  void discardAllChanges() {
    _changedTasks = {};
    toggleTodoTaskCardMode();
  }

  @override
  void toggleHomePageViewMode() {
    switch (homePageViewMode) {
      case HomePageViewMode.list:
        homePageViewMode = HomePageViewMode.calender;
        break;
      case HomePageViewMode.calender:
        homePageViewMode = HomePageViewMode.list;
        break;
    }
    selectedDay = DateTime.now();
    notifyListeners();
  }

  @override
  TodoTaskCardViewMode get getCardViewMode {
    switch (homePageViewMode) {
      case HomePageViewMode.list:
        return TodoTaskCardViewMode.list;
      case HomePageViewMode.calender:
        return TodoTaskCardViewMode.calender;
    }
  }

  @override
  void setSelectedDay(DateTime newDay) {
    selectedDay = newDay;
    notifyListeners();
  }

  @override
  String get getTitle {
    switch (homePageViewMode) {
      case HomePageViewMode.list:
        return AppStrings.todo;
      case HomePageViewMode.calender:
        return DateFormat('MMMM yyyy').format(selectedDay.toLocal());
    }
  }

  @override
  TodoTaskIcon getDayIcon(DateTime day) {
    final targetDay = DateTime(day.year, day.month, day.day);

    final isThisDayHasTasks = _todoTaskDayToTasksMap.containsKey(targetDay) &&
        _todoTaskDayToTasksMap[targetDay]!.isNotEmpty;

    if (isThisDayHasTasks) {
      return _todoTaskDayToTasksMap[targetDay]!.first.icon;
    }
    return TodoTaskIcon.none;
  }
}

abstract class _HomePageViewModelInputs {
  void goToAddNewTaskPage(BuildContext ctx, double width);

  void toggleTodoTaskCardMode();

  void toggleHomePageViewMode();

  void toggleCaredSelection(String id);
  void acceptAllChanges();
  void discardAllChanges();

  void setSelectedDay(DateTime newDay);

  TodoTaskIcon getDayIcon(DateTime day);
}

abstract class _HomePageViewModelOutputs {
  Stream<DataState> get onDataStateChanged;

  Map<String, TodoTask> get getTodoTasks;

  TodoTaskCardViewMode get getCardViewMode;

  String get getTitle;
}
