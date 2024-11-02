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
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: ColorTheme.black,
        ),
        titleSpacing: 0,
        iconTheme: IconThemeData(
          color: ColorTheme.black,
        ),
        actionsIconTheme: IconThemeData(
          color: ColorTheme.black,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: ColorTheme.black,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        displayMedium: TextStyle(
          color: ColorTheme.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        displaySmall: TextStyle(
          color: ColorTheme.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          color: ColorTheme.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        bodyLarge: TextStyle(
          color: ColorTheme.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
        bodyMedium: TextStyle(
          color: ColorTheme.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
        bodySmall: TextStyle(
          color: ColorTheme.black,
          fontSize: 8,
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
      ),
      indicatorColor: ColorTheme.primary,
      tabBarTheme: const TabBarTheme(
        labelColor: ColorTheme.black,
        labelStyle: TextStyle(
          color: ColorTheme.black,
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
