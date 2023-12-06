import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.teal,
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserratAlternates(),
        titleMedium: GoogleFonts.montserratAlternates(fontSize: 35),
        bodyLarge: GoogleFonts.montserratAlternates(fontSize: 35),
        bodyMedium: GoogleFonts.montserratAlternates(fontSize: 10),
      ));
}
