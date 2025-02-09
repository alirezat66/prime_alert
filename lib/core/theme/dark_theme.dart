import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF87EA62),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFF96FA70),
    secondary: Color(0xFF60CF67),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFF8AFB8D),
    surface: Color(0xFF111418),
    onSurface: Color(0xFFE1E2E8),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
  ),
  scaffoldBackgroundColor: const Color(0xFF111418),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF111418),
    foregroundColor: Color(0xFFE1E2E8),
    elevation: 0,
    centerTitle: false,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 96, fontWeight: FontWeight.w300, color: Color(0xFFE1E2E8)),
    displayMedium: TextStyle(
        fontSize: 60, fontWeight: FontWeight.w300, color: Color(0xFFE1E2E8)),
    displaySmall: TextStyle(
        fontSize: 48, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
    headlineLarge: TextStyle(
        fontSize: 40, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
    headlineMedium: TextStyle(
        fontSize: 34, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
    headlineSmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFFE1E2E8)),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
    titleSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFE1E2E8)),
    bodyLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFE1E2E8)),
    labelMedium: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
    labelSmall: TextStyle(
        fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF87EA62),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
    minWidth: 88,
    height: 36,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1D2024),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xFF8D9199),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xFF8D9199),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xFF60CF67),
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(const Color(0xFF87EA62)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF87EA62),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF60CF67),
      side: const BorderSide(color: Color(0xFF60CF67), width: 1.0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFFE1E2E8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: const Color(0xFFE1E2E8),
    contentPadding: const EdgeInsets.all(5.0),
    horizontalTitleGap: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>(
      (states) => const Color(0xFF60CF67),
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelStyle: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF60CF67)),
    unselectedLabelStyle: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFFE1E2E8)),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFF1D2024),
    modalBackgroundColor: Color(0xFF1D2024),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
    ),
  ),
  dividerColor: const Color(0xFFC3C7CF),
  shadowColor: Colors.black,
  hintColor: const Color(0xFF8D9199),
  splashColor: Colors.white30,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  primaryIconTheme: const IconThemeData(
    color: Colors.white,
  ),
  visualDensity: VisualDensity.compact,
);
