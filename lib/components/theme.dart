import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  final theme = ThemeData();
  final textTheme = GoogleFonts.jostTextTheme(theme.textTheme);

  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff5F8D4E),
    ),
    scaffoldBackgroundColor: const Color(0xffE5D9B6),
    textTheme: textTheme.copyWith(
      titleLarge: textTheme.titleLarge?.copyWith(color: Colors.white),
      titleMedium: textTheme.titleMedium?.copyWith(
        fontSize: 24,
        color: Colors.black,
      ),
      bodySmall: textTheme.bodySmall?.copyWith(
        color: Colors.black,
      ),
      bodyMedium: textTheme.bodyMedium?.copyWith(
        color: Colors.black,
        fontSize: 18,
      ),
      bodyLarge: textTheme.bodyLarge?.copyWith(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xffE5D9B6)),
    hintColor: Colors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff5F8D4E),
        ),
      ),
    ),
    cardTheme: const CardTheme(color: Color(0xff5F8D4E)),
    listTileTheme: const ListTileThemeData(
      tileColor: Color(0xffE5D9B6),
    ),
  );
  //floatingActionButtonTheme: FloatingActionButton());
}
