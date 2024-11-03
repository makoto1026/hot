import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/theme/color_theme.dart';

final lightThemeProvider = Provider<ThemeData>(
  (ref) {
    return ThemeData(
      fontFamily: 'NotoSansJP',
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.transparent),
      dividerTheme: const DividerThemeData(
        space: 0,
        color: Color(
          0xffD9D9D9,
        ),
      ),
      scaffoldBackgroundColor: ColorTheme.blue,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: ColorTheme.blue,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: ColorTheme.white,
        ),
        titleSpacing: 0,
        iconTheme: IconThemeData(
          color: ColorTheme.white,
        ),
        actionsIconTheme: IconThemeData(
          color: ColorTheme.white,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: ColorTheme.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        displayMedium: TextStyle(
          color: ColorTheme.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        displaySmall: TextStyle(
          color: ColorTheme.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          color: ColorTheme.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        bodyLarge: TextStyle(
          color: ColorTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
        bodyMedium: TextStyle(
          color: ColorTheme.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
        bodySmall: TextStyle(
          color: ColorTheme.white,
          fontSize: 8,
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
      ),
      indicatorColor: ColorTheme.white,
      tabBarTheme: const TabBarTheme(
        labelColor: ColorTheme.white,
        labelStyle: TextStyle(
          color: ColorTheme.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  },
);
