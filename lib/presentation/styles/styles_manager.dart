import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamilyLato,
    color: color,
    fontWeight: fontWeight,
  ));
}

// regular style
TextStyle getRegularStyle(
    {double fontSize = FontSizeConstants.s14, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWeightConstants.regular,
    color,
  );
}

// medium style
TextStyle getMediumStyle({
  double fontSize = FontSizeConstants.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightConstants.medium,
    color,
  );
}

// medium style
TextStyle getLightStyle({
  double fontSize = FontSizeConstants.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightConstants.light,
    color,
  );
}

// bold style
TextStyle getBoldStyle({
  double fontSize = FontSizeConstants.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightConstants.bold,
    color,
  );
}

// semibold style
TextStyle getSemiBoldStyle({
  double fontSize = FontSizeConstants.s14,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightConstants.semiBold,
    color,
  );
}
