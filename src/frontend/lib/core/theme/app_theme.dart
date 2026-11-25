import 'package:flutter/material.dart';

/// Colores extraídos de las variables de `docs/pantallas.pen`.
class AppColors {
  AppColors._();

  static const bg = Color(0xFF111118);
  static const surface = Color(0xFF1A1A24);
  static const text = Color(0xFFD0D0D8);
  static const muted = Color(0xFF88889A);
  static const accent = Color(0xFF4AAA8A);
  static const bright = Color(0xFF6ACCAA);
  static const border = Color(0xFF2A2A3A);
  static const borderLight = Color(0xFF3A3A4A);
  static const danger = Color(0xFFD45A5A);
  static const warning = Color(0xFFD6A74A);
  static const soft = Color(0xFF1A2A24);
  static const dangerPanel = Color(0xFF321D25);
}

/// Tema oscuro de la app: fuente Workbench y esquinas rectas (estilo pixel del mockup).
class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Workbench',
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.bright,
        surface: AppColors.surface,
        onSurface: AppColors.text,
        error: AppColors.danger,
        outline: AppColors.borderLight,
      ),
      hintColor: AppColors.muted,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.text,
        displayColor: AppColors.text,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        isDense: true,
        hintStyle: const TextStyle(fontSize: 9, color: AppColors.muted),
        labelStyle: const TextStyle(fontSize: 9, color: AppColors.muted),
        prefixIconColor: AppColors.muted,
        suffixIconColor: AppColors.muted,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.accent),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.soft,
          foregroundColor: AppColors.bright,
          disabledBackgroundColor: AppColors.soft,
          disabledForegroundColor: AppColors.muted,
          side: const BorderSide(color: AppColors.accent),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.text,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
        shape: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle: TextStyle(fontSize: 9, color: AppColors.text),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    );
  }
}
