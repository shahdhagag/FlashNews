import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/core/utiles/app_colors.dart';
import 'package:newsapp/core/utiles/app_styles.dart';

class AppTheme {

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.whiteColor,
      foregroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
    ),

    drawerTheme: DrawerThemeData(
      width: 269,
      backgroundColor: AppColors.black,
    ),
    textTheme: TextTheme(
      bodyLarge: AppStyles.medium20Black, // main body text
      bodyMedium: AppStyles.medium14Black, // secondary text
      titleLarge: AppStyles.bold24Black, // titles
      titleMedium: AppStyles.bold20Black, // subtitles
      labelLarge: AppStyles.medium14Black, // buttons or small labels
      labelMedium: AppStyles.bold16Black, // buttons or small labels
      labelSmall: AppStyles.medium12Black, // buttons or small labels

    ),
  );


  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.black,
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),

    drawerTheme: DrawerThemeData(
      width: 269,
      backgroundColor: const Color(0xFF1E1E1E), // soft dark, not pure black
    ),

    textTheme: TextTheme(
      bodyLarge: AppStyles.medium20White,
      bodyMedium: AppStyles.medium14White,
      titleLarge: AppStyles.bold24White,
      titleMedium: AppStyles.bold20White,
      labelLarge: AppStyles.medium14White,
      labelMedium: AppStyles.bold16White, // buttons or small labels
      labelSmall: AppStyles.medium12white, // buttons or small labels


    ),

    iconTheme: const IconThemeData(
      color: Colors.white,
    ),


  );
}
