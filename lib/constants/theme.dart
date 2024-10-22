import 'package:dreamhrms/constants/colors.dart';
import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.white
        ),
        titleTextStyle: TextStyle(
            color: AppColors.white
        )
      ),
      tabBarTheme: TabBarTheme(
        indicatorColor: AppColors.blue,
        labelColor: AppColors.blue
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.white, // Set your desired cursor color
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700),
          borderRadius: BorderRadius.circular(8),
        ),
          errorStyle: TextStyle(
              color: Colors.red.shade700
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )
      ),
      colorScheme: ColorScheme.dark(
        primary: AppColors.blue,
        secondary: AppColors.blue
      ));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
              color: AppColors.black
          ),
          titleTextStyle: TextStyle(
              color: AppColors.black
          )
      ),
      tabBarTheme: TabBarTheme(
          indicatorColor: AppColors.blue,
          labelColor: AppColors.blue
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.black, // Set your desired cursor color
      ),
      inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700),
            borderRadius: BorderRadius.circular(8),
          ),
        errorStyle: TextStyle(
            color: Colors.red.shade700
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
      colorScheme: ColorScheme.light(
          primary: AppColors.blue,
          secondary: AppColors.blue
      ));
}