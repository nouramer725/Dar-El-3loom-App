import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   selectedItemColor: AppColors.whiteColor,
    //   unselectedItemColor: AppColors.appColor,
    //   type: BottomNavigationBarType.fixed,
    //   showSelectedLabels: true,
    //   showUnselectedLabels: false,
    // ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.whiteColor,
      iconTheme: IconThemeData(
        color: AppColors.blackColor
      )
    )
  );
  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.blackColor,
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   selectedItemColor: AppColors.whiteColor,
      //   unselectedItemColor: AppColors.appColor,
      //   type: BottomNavigationBarType.fixed,
      //   showSelectedLabels: true,
      //   showUnselectedLabels: false,
      // ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColors.whiteColor,
          iconTheme: IconThemeData(
              color: AppColors.blackColor
          )
      )
  );
}
