import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_sizes.dart';

class AppTextStyles {
  // Headings
  static const TextStyle h1 = TextStyle(
    fontSize: AppSizes.text4xl,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  
  static const TextStyle h2 = TextStyle(
    fontSize: AppSizes.text3xl,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static const TextStyle h3 = TextStyle(
    fontSize: AppSizes.text2xl,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static const TextStyle h4 = TextStyle(
    fontSize: AppSizes.textXl,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  // Body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: AppSizes.textLg,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: AppSizes.textBase,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: AppSizes.textSm,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );
  
  // Labels
  static const TextStyle label = TextStyle(
    fontSize: AppSizes.textSm,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: AppSizes.textXs,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.3,
  );
  
  // Button text
  static const TextStyle button = TextStyle(
    fontSize: AppSizes.textBase,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
  
  static const TextStyle buttonSmall = TextStyle(
    fontSize: AppSizes.textSm,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
  
  // Caption
  static const TextStyle caption = TextStyle(
    fontSize: AppSizes.textXs,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
    height: 1.3,
  );
}