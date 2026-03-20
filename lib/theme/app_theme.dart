import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Color Tokens ──
  static const Color brandYellow = Color(0xFFF5C518);
  static const Color bgDark = Color(0xFF141414); // scaffold / page bg
  static const Color cardDark = Color(0xFF1E1E1E); // card surface
  static const Color elevatedDark = Color(0xFF272727); // dark grey
  static const Color pressedDark = Color(0xFF313131);
  static const Color textWhite = Color(0xFFF0EDE6);
  static const Color textGrey = Color(0xFF777777); // secondary
  static const Color statusGreen = Color(0xFF4AE08A);
  static const Color dividerGrey = Color(0x12FFFFFF); // borders / dividers

  static final ThemeData appTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgDark,
    primaryColor: brandYellow,

    colorScheme: const ColorScheme.dark(
      primary: brandYellow,
      surface: cardDark,
      surfaceContainerHigh: elevatedDark, // photo bg, avatar fill
      onSurface: textWhite,
      onSurfaceVariant: textGrey,
      outlineVariant: dividerGrey,
      secondary: statusGreen,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: cardDark,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    textTheme: GoogleFonts.orbitTextTheme(ThemeData.dark().textTheme),

    dividerTheme: const DividerThemeData(
      color: dividerGrey,
      thickness: 1,
      space: 50,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: cardDark,
      selectedItemColor: brandYellow,
      unselectedItemColor: textGrey,
      elevation: 0,
    ),
  );
}
