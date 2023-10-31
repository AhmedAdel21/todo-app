import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/di.dart';
import 'package:todo_app/domain/managers/notification_manager.dart';
import 'package:todo_app/domain/model/models.dart';
import 'package:todo_app/domain/usecase/inputs.dart';
import 'package:todo_app/domain/usecase/usecase.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';
import 'package:todo_app/presentation/ui/common/base_viewmodel/base_viewmodel.dart';
import 'package:todo_app/presentation/ui/common/toast/toast.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';

class AddNewTaskPageViewModel extends BaseViewModel
    with ChangeNotifier
    implements _AddNewTaskPageViewModelInputs, _AddNewTaskPageViewModelOutputs {
  final StreamController<String> _taskNameSC =
      StreamController<String>.broadcast();
  final StreamController<String> _taskDescriptionSC =
      StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  AddTodoTaskObject _addTodoTaskObject = AddTodoTaskObject();

  TodoTaskIcon defaultIcon = TodoTaskIcon.shopCardIcon;
  DateTime defaultDate = DateTime.now();
  TimeOfDay defaultTime = TimeOfDay.now();

  final AddTodoTaskUseCase addTodoTaskUseCase;
  AddNewTaskPageViewModel(this.addTodoTaskUseCase);
  @override
  void start() {
    _addTodoTaskObject = AddTodoTaskObject()
      ..icon = defaultIcon.imagePath
      ..dateTime = defaultDate
      ..timeOfDay = defaultTime;
  }

  @override
  String get getDate =>
      DateFormat('dd - MMMM - yyyy').format(defaultDate.toLocal());

  @override
  String get getTime => "${defaultTime.hour} : ${defaultTime.minute}";
  @override
  String get getTimeSuffix => defaultTime.period == DayPeriod.am ? "AM" : "PM";
  @override
  void destroy() {
    _taskNameSC.close();
    _taskDescriptionSC.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream.map((_) => _isAllInputsValid);

  @override
  Stream<String?> get outputErrorTaskDescriptionMessage =>
      _taskDescriptionSC.stream.map((taskDescription) {
        final errorMessage = taskDescriptionValidator(taskDescription);
        if (errorMessage == null) {
          _addTodoTaskObject.description = taskDescription;
        } else {
          _addTodoTaskObject.description = null;
        }
        return errorMessage;
      });

  @override
  Stream<String?> get outputErrorTaskNameMessage =>
      _taskNameSC.stream.map((taskName) {
        final errorMessage = taskNameValidator(taskName);
        if (errorMessage == null) {
          _addTodoTaskObject.name = taskName;
        } else {
          _addTodoTaskObject.name = null;
        }
        return errorMessage;
      });

  @override
  void setTaskDescription(String taskDescription) {
    _taskDescriptionSC.add(taskDescription);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setTaskName(String taskName) {
    _taskNameSC.add(taskName);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  String? taskNameValidator(String? taskName) {
    if (taskName == null) {
      return AppStrings.fieldCanNotBeEmpty;
    }

    if (taskName.isEmpty) {
      return AppStrings.fieldCanNotBeEmpty;
    }
    return null;
  }

  @override
  String? taskDescriptionValidator(String? taskDescription) {
    if (taskDescription == null) {
      return AppStrings.fieldCanNotBeEmpty;
    }
    if (taskDescription.isEmpty) {
      return AppStrings.fieldCanNotBeEmpty;
    }
    return null;
  }

  bool get _isAllInputsValid {
    return _isNotNull(_addTodoTaskObject.icon) &&
        _isNotNull(_addTodoTaskObject.name) &&
        _isNotNull(_addTodoTaskObject.description) &&
        _isNotNull(_addTodoTaskObject.dateTime) &&
        _isNotNull(_addTodoTaskObject.timeOfDay);
  }

  bool _isNotNull(Object? ob) => ob != null;

  @override
  void addNewTask(BuildContext ctx, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate() && _isAllInputsValid) {
      final newTodoTask = AddTodoTaskUseCaseInput(
        icon: _addTodoTaskObject.icon!,
        name: _addTodoTaskObject.name!,
        description: _addTodoTaskObject.description!,
        dateTime: _addTodoTaskObject.dateTime!,
        timeOfDay: _addTodoTaskObject.timeOfDay!,
      );
      (await addTodoTaskUseCase.execute(newTodoTask)).fold((left) {
        ctx.pop();
        ToastManager.showTextToast(
            "${AppStrings.failedToAddTask}[${left.message}]");
      }, (id) {
        ctx.pop();
        DI
            .getItInstance<NotificationManager>()
            .showNotification(NotificationContent(
              id,
              title: newTodoTask.name,
              body: newTodoTask.description,
              payload: id.toString(),
            ));

        ToastManager.showTextToast(AppStrings.newTaskAdded);
      });
    } else {}
  }

  @override
  void setTaskIcon(TodoTaskIcon icon) {
    defaultIcon = icon;
    _addTodoTaskObject.icon = defaultIcon.imagePath;
    notifyListeners();
  }

  @override
  void setDate(DateTime date) {
    defaultDate = date;
    _addTodoTaskObject.dateTime = defaultDate;
    notifyListeners();
  }

  @override
  void setTime(TimeOfDay time) {
    defaultTime = time;
    _addTodoTaskObject.timeOfDay = defaultTime;
    notifyListeners();
  }
}

abstract class _AddNewTaskPageViewModelInputs {
  void setTaskName(String taskName);
  void setTaskDescription(String taskDescription);
  void setTaskIcon(TodoTaskIcon icon);
  void setDate(DateTime date);
  void setTime(TimeOfDay time);

  void addNewTask(BuildContext ctx, GlobalKey<FormState> formKey);

  String? taskNameValidator(String? taskName);
  String? taskDescriptionValidator(String? taskDescription);
}

abstract class _AddNewTaskPageViewModelOutputs {
  Stream<String?> get outputErrorTaskNameMessage;

  Stream<String?> get outputErrorTaskDescriptionMessage;

  Stream<bool> get outputAreAllInputsValid;

  String get getDate;
  String get getTime;
  String get getTimeSuffix;
}
