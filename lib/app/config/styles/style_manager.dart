import 'package:electronic_shop/app/core/constants/font_manager.dart';
import 'package:electronic_shop/app/core/constants/value_manager.dart';
import 'package:flutter/cupertino.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
}

//regular text style
TextStyle getRegularStyle(
    {double fontSize = AppSize.S12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.REGULAR, color);
}

//medium
TextStyle getMediumStyle(
    {double fontSize = AppSize.S12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.MEDIUM, color);
}

//semi bold text style
TextStyle getSemiBoldStyle(
    {double fontSize = AppSize.S12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.SEMI_BOLD, color);
}

//bold style
TextStyle getBoldStyle({double fontSize = AppSize.S12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.BOLD, color);
}
