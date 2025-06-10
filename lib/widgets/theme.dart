import 'package:flutter/material.dart';

ThemeData appTheme(){
  Color primaryColor = const Color.fromARGB(255, 0, 98, 179);
  Color surfaceColor = Colors.white;

  return ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    useMaterial3: true,
    scaffoldBackgroundColor: surfaceColor,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceColor,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: surfaceColor,
      shape: const RoundedRectangleBorder()
    ),
    cardTheme: CardTheme(
      color: const Color.fromARGB(255, 250, 250, 250),//surfaceColor,
      elevation: 0,
      shadowColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(10)
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent[700]!),
        borderRadius: BorderRadius.circular(10)
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(10)
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white60),
        borderRadius: BorderRadius.circular(10)
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[100],
    ),
  );
}

ThemeData darkAppTheme(){
  Color primaryColor = const Color(0xFF0062B3);
  Color surfaceColor = const Color(0xFF141A22);
  Color deepColor = const Color(0xFF11161D);

  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.dark),
    useMaterial3: true,
    scaffoldBackgroundColor: deepColor,
    appBarTheme: AppBarTheme(
      backgroundColor: deepColor,
      centerTitle: true,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: deepColor,
      shape: const RoundedRectangleBorder()
    ),
    cardTheme: CardTheme(
      color: surfaceColor,
      elevation: 0,
      shadowColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(10)
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent[700]!),
        borderRadius: BorderRadius.circular(10)
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(10)
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white60),
        borderRadius: BorderRadius.circular(10)
      ),
    ),
    dividerTheme: DividerThemeData(
      color: surfaceColor,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: primaryColor
    )
  );
}