import 'package:flutter/material.dart';

class AppTheme {
  // ── фирменные цвета
  static const _bg     = Color(0xFFE5D8C6);
  static const _accent = Color(0xFF2B4464);

  // ── базовые размеры
  static const _title  = 22.0;   // было 20
  static const _body   = 16.0;   // было 14
  static const _button = 18.0;

  static ThemeData light() => ThemeData(
        useMaterial3          : true,
        scaffoldBackgroundColor: _bg,
        colorScheme           : ColorScheme.light(
          primary  : _accent,
          secondary: _accent,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily : 'Inter',
            fontWeight : FontWeight.w700,
            fontSize   : _title,
          ),
          bodyMedium: TextStyle(
            fontFamily : 'Inter',
            fontWeight : FontWeight.w500,
            fontSize   : _body,
          ),
          labelLarge: const TextStyle(fontFamily: 'Inter')
              .copyWith(fontSize: _button, fontWeight: FontWeight.w600),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _accent,
            foregroundColor: Colors.white,
            textStyle      : const TextStyle(fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      );
}
