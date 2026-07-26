import 'package:flutter/material.dart';
import 'package:event/core/constants/app_colors.dart';

import '../constants/app_colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.white),
    titleTextStyle: TextStyle(
      color: AppColors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.white),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkText),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.grey),
  ),
  cardTheme: const CardThemeData(
    color: AppColors.darkCard,
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      minimumSize: const Size(double.infinity, 55),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);
