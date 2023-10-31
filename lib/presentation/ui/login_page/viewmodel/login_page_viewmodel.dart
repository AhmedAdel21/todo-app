import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/di.dart';
import 'package:todo_app/app/global_functions.dart';
import 'package:todo_app/domain/usecase/inputs.dart';
import 'package:todo_app/domain/usecase/login_usecase.dart';
import 'package:todo_app/presentation/navigation/app_router.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';
import 'package:todo_app/presentation/ui/common/base_viewmodel/base_viewmodel.dart';
import 'package:todo_app/presentation/ui/common/state_renderer/state_renderer.dart';
import 'package:todo_app/presentation/ui/common/state_renderer/state_renderer_impl.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';

class LoginPageViewModel extends BaseViewModel
    with ChangeNotifier
    implements _LoginPageViewModelInputs, _LoginPageViewModelOutputs {
  final StreamController<String> _userNameC =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordSC =
      StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  UserLoginData userData = UserLoginData();

  LoginPageViewModel();
  @override
  void start() {}

  @override
  void destroy() {}

  @override
  void setUserName(String userName) {
    _userNameC.add(userName);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  void setPassword(String password) {
    _passwordSC.add(password);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  Stream<String?> get onPasswordErrorMessage =>
      _passwordSC.stream.map((password) {
        final errorMessage = passwordValidator(password);
        if (errorMessage == null) {
          userData.password = password;
        } else {
          userData.password = null;
        }
        return errorMessage;
      });

  @override
  Stream<String?> get onUserNameErrorMessage =>
      _userNameC.stream.map((userName) {
        final errorMessage = userNameValidator(userName);
        if (errorMessage == null) {
          userData.userName = userName;
        } else {
          userData.userName = null;
        }
        return errorMessage;
      });

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream.map((_) => _isAllInputsValid);

  bool get _isAllInputsValid =>
      isNotNull(userData.userName) && isNotNull(userData.password);

  @override
  String? userNameValidator(String? userName) {
    if (userName == null) {
      return AppStrings.fieldCanNotBeEmpty;
    }

    if (userName.isEmpty) {
      return AppStrings.fieldCanNotBeEmpty;
    }
    return null;
  }

  @override
  String? passwordValidator(String? password) {
    if (password == null) {
      return AppStrings.fieldCanNotBeEmpty;
    }
    if (password.isEmpty) {
      return AppStrings.fieldCanNotBeEmpty;
    }
    return null;
  }

  @override
  void login(BuildContext ctx, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate() && _isAllInputsValid) {
      await LoadingState(stateRendererType: StateRendererType.popupLoadingState)
          .showPopup(
              ctx, StateRendererType.popupLoadingState, AppStrings.loading);
      (await DI.getItInstance<LoginUseCase>().execute(UserLoginDataUseCaseInput(
              userData.userName!, userData.password!)))
          .fold((left) {
        dismissDialog(ctx);

        ErrorState(
                stateRendererType: StateRendererType.popupErrorState,
                message: left.message)
            .showPopup(ctx, StateRendererType.popupErrorState, left.message);
      }, (right) {
        dismissDialog(ctx);

        ctx.pushReplacementNamed(RoutesName.home);
      });
    }
  }
}

abstract class _LoginPageViewModelInputs {
  void setUserName(String userName);
  void setPassword(String password);

  String? userNameValidator(String? userName);
  String? passwordValidator(String? password);

  void login(BuildContext ctx, GlobalKey<FormState> formKey);
}

abstract class _LoginPageViewModelOutputs {
  Stream<String?> get onUserNameErrorMessage;

  Stream<String?> get onPasswordErrorMessage;

  Stream<bool> get outputAreAllInputsValid;
}
