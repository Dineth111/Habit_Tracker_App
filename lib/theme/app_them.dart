import 'package:flutter/material.dart';

class AppTheme {
  static final ColorScheme _scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF7C3AED),
    brightness: Brightness.light,
  );

  static ThemeData get light {
    return ThemeData(
      colorScheme: _scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF3F4F6),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        bodyMedium: TextStyle(
          letterSpacing: 0.1,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _scheme.surface,
        foregroundColor: _scheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => _scheme.primary,
        ),
        checkColor: WidgetStateProperty.all(_scheme.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.black.withValues(alpha: 0.04),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _scheme.primary,
        foregroundColor: _scheme.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
      ),
    );
  }
}
