import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle base = TextStyle(
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2,
  );

  static TextStyle get title => base.copyWith(
    fontSize: 42,
    color: AppColors.primary,
  );

  static TextStyle get button => base.copyWith(
    fontSize: 28,
    color: AppColors.secondary,
  );
  
  static TextStyle get sideTitle => base.copyWith(
    fontSize: 34,
    color: AppColors.primary,
  );
}

