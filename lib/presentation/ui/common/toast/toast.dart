import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/app/di.dart';
import 'package:todo_app/presentation/navigation/app_navigation_manager.dart';
import 'package:todo_app/presentation/resources/color_manager.dart';

class ToastManager {
  static void showTextToast(String text,
      {Color backgroundColor =
          ColorConstants.toastBackgroundColorColor}) async {
    if (DI.getItInstance<AppNavigationManager>().isAppActive) {
      await _destroyToast();
      Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: ColorConstants.toastTextColor,
        fontSize: 16.0,
      );
    }
  }

  static Future<void> _destroyToast() async => await Fluttertoast.cancel();
}
