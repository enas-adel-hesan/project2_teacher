import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/dimensions/font_size.dart';
import '../constants/dimensions/font_weight.dart';

TextStyle _getTextStyle(
    double fontSize, Color fontColor, FontWeight fontWeight) {
  return GoogleFonts.poppins(

      color: fontColor,
      fontSize: fontSize,
      fontWeight: fontWeight,

      );
}

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, color, AppFontWeight.bold);
}

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, color, AppFontWeight.semiBold);
}

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, color, AppFontWeight.medium);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, color, AppFontWeight.regular);
}

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, color, AppFontWeight.light);
}
