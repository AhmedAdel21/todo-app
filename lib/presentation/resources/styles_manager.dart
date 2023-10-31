import 'package:flutter/material.dart';
import 'package:todo_app/presentation/resources/font_manager.dart';

enum AppFontFamily { lato, baloo }

TextStyle _getTextStyle(AppFontFamily fontFamily, double fontSize,
    FontWeight fontWeight, Color color) {
  String targetFontFamily;
  switch (fontFamily) {
    case AppFontFamily.lato:
      targetFontFamily = FontConstants.fontFamilyLato;
      break;
    case AppFontFamily.baloo:
      targetFontFamily = FontConstants.fontFamilyBaloo;
      break;
  }
  return TextStyle(
    fontSize: fontSize,
    fontFamily: targetFontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

// regular style
TextStyle getRegularStyle(
    {required AppFontFamily fontFamily,
    double fontSize = FontSizeConstants.s12,
    required Color color}) {
  return _getTextStyle(
    fontFamily,
    fontSize,
    FontWeightConstants.regular,
    color,
  );
}

// medium style
TextStyle getMediumStyle({
  required AppFontFamily fontFamily,
  double fontSize = FontSizeConstants.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontFamily,
    fontSize,
    FontWeightConstants.medium,
    color,
  );
}

// Black style
TextStyle getBlackStyle({
  required AppFontFamily fontFamily,
  double fontSize = FontSizeConstants.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontFamily,
    fontSize,
    FontWeightConstants.black,
    color,
  );
}

// Light style
TextStyle getLightStyle({
  required AppFontFamily fontFamily,
  double fontSize = FontSizeConstants.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontFamily,
    fontSize,
    FontWeightConstants.light,
    color,
  );
}

// bold style
TextStyle getBoldStyle({
  required AppFontFamily fontFamily,
  double fontSize = FontSizeConstants.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontFamily,
    fontSize,
    FontWeightConstants.bold,
    color,
  );
}

// semibold style
TextStyle getSemiBoldStyle({
  required AppFontFamily fontFamily,
  double fontSize = FontSizeConstants.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontFamily,
    fontSize,
    FontWeightConstants.semiBold,
    color,
  );
}
