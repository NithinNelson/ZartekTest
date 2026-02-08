
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightThemeData = ThemeData(
  useMaterial3: true,

  primaryColor: const Color(0xFF2E7D32),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2E7D32),
    primary: const Color(0xFF2E7D32),
    secondary: const Color(0xFFD32F2F),
    surface: Colors.white,
  ),

  scaffoldBackgroundColor: Colors.white,

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18.h,
      fontWeight: FontWeight.w600,
    ),
  ),

  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontSize: 16.h,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 20.h,
      color: Colors.black87,
    ),
    bodySmall: TextStyle(
      fontSize: 12.h,
      color: Colors.grey,
    ),
  ),

  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12).r,
    ),
    margin: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2E7D32),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).r,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
    ),
  ),

  iconTheme: IconThemeData(
    color: Color(0xFF2E7D32),
    size: 20.h,
  ),

  dividerTheme: DividerThemeData(
    color: Colors.grey.shade300,
    thickness: 1.h,
  ),
);

SystemUiOverlayStyle systemUiOverlayStyleLight = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.white,
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  systemStatusBarContrastEnforced: false,
  systemNavigationBarIconBrightness: Brightness.light,
);