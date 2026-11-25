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

/// Tema oscuro de la app con tipografía legible y encabezados pixelados.
class AppTheme {
  AppTheme._();

  static const headingFontFamily = 'DotGothic16';
  static const bodyFontFamily = 'Inter';

  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: bodyFontFamily,
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
    final textTheme = base.textTheme.apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    );
    final themedTextTheme = textTheme.copyWith(
      displayLarge:
          textTheme.displayLarge?.copyWith(fontFamily: headingFontFamily),
      displayMedium:
          textTheme.displayMedium?.copyWith(fontFamily: headingFontFamily),
      displaySmall:
          textTheme.displaySmall?.copyWith(fontFamily: headingFontFamily),
      headlineLarge:
          textTheme.headlineLarge?.copyWith(fontFamily: headingFontFamily),
      headlineMedium:
          textTheme.headlineMedium?.copyWith(fontFamily: headingFontFamily),
      headlineSmall:
          textTheme.headlineSmall?.copyWith(fontFamily: headingFontFamily),
    );

    return base.copyWith(
      textTheme: themedTextTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        isDense: true,
         hintStyle: const TextStyle(fontSize: 14, color: AppColors.muted),
         labelStyle: const TextStyle(fontSize: 14, color: AppColors.muted),
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
            fontFamily: bodyFontFamily,
             fontSize: 14,
            fontWeight: FontWeight.w700,
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
          fontFamily: headingFontFamily,
           fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.text,
        ),
        shape: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.surface,
         contentTextStyle: TextStyle(fontSize: 14, color: AppColors.text),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    );
  }
}
