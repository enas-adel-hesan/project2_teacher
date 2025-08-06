import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors_manager.dart';
import '../constants/dimensions/font_size.dart';
import '../constants/dimensions/padding.dart';
import '../constants/dimensions/radius.dart';
import '../constants/dimensions/size.dart';
import 'font_manager.dart';
import 'style_manager.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.background,

      surfaceContainerHighest: AppColors.surfaceVariant,
      brightness: Brightness.light,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: false,
      fontFamily: FontConstants.fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      //=========App Bar=================================================
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black26,
        centerTitle: true,
        foregroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: getSemiBoldStyle(
          color: AppColors.textPrimary,
          fontSize: FontSize.s30,
        ),
        labelLarge: getBoldStyle(
          color: AppColors.textPrimary,
          fontSize: FontSize.s30,
        ),
        headlineMedium: getRegularStyle(
          color: AppColors.textPrimary,
          fontSize: FontSize.s16,
        ),
        titleLarge: getSemiBoldStyle(
          color: AppColors.primary,
          fontSize: FontSize.s16,
        ),
        titleMedium: getMediumStyle(
          color: AppColors.textPrimary,
          fontSize: FontSize.s16,
        ),
        bodyMedium: getRegularStyle(
          color: AppColors.textSecondary,
          fontSize: FontSize.s16,
        ),
      ),

      //=======Elevated Button==================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r4),
          ),
          textStyle: getMediumStyle(
            color: colorScheme.onPrimary,
            fontSize: AppSize.s20,
          ),
        ),
      ),
      //===============Outlined Button===========================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 1),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: getSemiBoldStyle(
            color: Colors.white,
            fontSize: AppSize.s16,
          ),
        ),
      ),
      //========================================================
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: getMediumStyle(
          color: AppColors.textPrimary,
          fontSize: AppSize.s16,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r4),
          borderSide: BorderSide(
            color: colorScheme.onSecondary,
            width: AppSize.s1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r4),
          borderSide: BorderSide(
            color: colorScheme.onSecondary,
            width: AppSize.s1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r4),
          borderSide: BorderSide(color: AppColors.primary, width: AppSize.s1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r4),
          borderSide: BorderSide(color: AppColors.error, width: AppSize.s1_5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r4),
          borderSide: BorderSide(color: AppColors.error, width: AppSize.s1_5),
        ),
      ),
    );
  }
}
