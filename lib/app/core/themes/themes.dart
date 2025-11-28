import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  Themes._();

  static ThemeData of(BuildContext context) {
    final theme = Theme.of(context);

    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(Colors.grey),
      ),
      primaryColor: Colors.purple,
      colorScheme: theme.colorScheme
          .copyWith(
        primary: Colors.purple,
      )
          .copyWith(surface: Colors.white),
    );
  }
}
