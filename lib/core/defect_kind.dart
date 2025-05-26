import 'package:flutter/material.dart';

enum DefectKind {
  badTop(iconName: 'defect_bad_top', label: 'Брак верх', defectColor: Color(0xFFB71C1C), fontSize: 18.0),
  badBottom(iconName: 'defect_bad_bottom', label: 'Брак низ', defectColor: Color(0xFFB71C1C), fontSize: 18.0),
  badSet(iconName: 'defect_bad_set', label: 'Брак комплект', defectColor: Color(0xFFB71C1C), fontSize: 18.0),
  sizeTop(iconName: 'defect_size_top', label: 'Размер верх', defectColor: Color(0xFF1B5E20), fontSize: 16.0),
  sizeBottom(iconName: 'defect_size_bottom', label: 'Размер низ', defectColor: Color(0xFF1B5E20), fontSize: 16.0),
  sizeSet(iconName: 'defect_size_set', label: 'Размер комплект', defectColor: Color(0xFF1B5E20), fontSize: 18.0),
  colorDefect(iconName: 'defect_color', label: 'Разноцвет', defectColor: Color(0xFF1A237E), fontSize: 18.0),  other(iconName: 'defect_other', label: 'Другое', defectColor: Color(0xFF4A148C), fontSize: 18.0), // Тёмно-фиолетовый
  ok(iconName: 'defect_ok', label: 'OK', defectColor: Color(0xFF424242), fontSize: 18.0); // Тёмно-серый

  final String iconName;
  final String label;
  final Color defectColor;
  final double fontSize;

  const DefectKind({
    required this.iconName,
    required this.label,
    required this.defectColor,
    required this.fontSize,
  });

  String get iconPath => 'assets/icons/defects/$iconName.png';
}
