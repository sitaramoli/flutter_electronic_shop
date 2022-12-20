import 'package:electronic_shop/app/config/styles/style_manager.dart';
import 'package:electronic_shop/app/core/constants/color_manager.dart';
import 'package:electronic_shop/app/core/constants/strings_manager.dart';
import 'package:electronic_shop/app/core/constants/value_manager.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static final themeData = ThemeData(
    //app main colors
    primaryColor: ColorManager.PRIMARY,
    disabledColor: ColorManager.GREY,

    //card theme
    cardTheme: const CardTheme(
      color: ColorManager.LIGHT_GREY,
      shadowColor: ColorManager.GREY,
      elevation: AppSize.S4,
    ),

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.PRIMARY,
      elevation: AppSize.S4,
      shadowColor: ColorManager.PRIMARY_70,
      titleTextStyle: getRegularStyle(
        color: ColorManager.WHITE,
        fontSize: AppSize.S15,
      ),
    ),

    //button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.GREY,
      buttonColor: ColorManager.PRIMARY,
      splashColor: ColorManager.PRIMARY_70,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.WHITE),
          backgroundColor: ColorManager.PRIMARY,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.S12))),
    ),

    //input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.LIGHT_GREY,
      contentPadding: const EdgeInsets.all(AppPadding.P8),
      iconColor: ColorManager.PRIMARY,
      //hint style
      hintStyle:
          getRegularStyle(color: ColorManager.GREY, fontSize: AppSize.S15),
      //error style
      errorStyle:
          getRegularStyle(color: ColorManager.ERROR, fontSize: AppSize.S15),

      //enabled border
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.GREY, width: AppSize.S1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.S12)),
      ),

      //focused border
      focusedBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.PRIMARY, width: AppSize.S1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.S12)),
      ),

      //error border
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.ERROR, width: AppSize.S1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.S12)),
      ),
    ),

    fontFamily: StringManager.FONT_FAMILY,
    iconTheme: const IconThemeData(color: ColorManager.PRIMARY),

    //text theme
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(
          color: ColorManager.DARK_GREY, fontSize: AppSize.S35),
      headline2: getRegularStyle(
          color: ColorManager.LIGHT_GREY, fontSize: AppSize.S30),
      headline3:
          getBoldStyle(color: ColorManager.PRIMARY, fontSize: AppSize.S25),
      headline4:
          getRegularStyle(color: ColorManager.DARK_GREY, fontSize: AppSize.S20),
      headline5:
          getSemiBoldStyle(color: ColorManager.GREY, fontSize: AppSize.S20),
      subtitle1:
          getMediumStyle(color: ColorManager.DARK_GREY, fontSize: AppSize.S16),
      subtitle2:
          getMediumStyle(color: ColorManager.PRIMARY, fontSize: AppSize.S16),
      bodyText2: getMediumStyle(color: ColorManager.GREY),
      caption: getRegularStyle(color: ColorManager.GREY),
      button: getSemiBoldStyle(color: ColorManager.LIGHT_GREY),
    ),
  );
}
