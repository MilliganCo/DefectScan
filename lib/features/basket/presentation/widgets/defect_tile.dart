// lib/features/basket/presentation/widgets/defect_tile.dart
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import '../../../../core/defect_kind.dart';

class DefectTile extends StatelessWidget {
  const DefectTile({
    super.key,
    required this.defectKind,
    required this.onTap,
    required this.selected,
  });

  final DefectKind defectKind;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      height: 120,
      width: 120,
      spread: selected ? 4 : 2,
      depth: selected ? 60 : 40,
      color: const Color.fromARGB(200, 145, 145, 145),
      borderRadius: 12,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Фоновая иконка
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  defectKind.iconPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Полупрозрачный overlay для лучшей читаемости текста
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            // Интерактивный слой с текстом
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      defectKind.label.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: defectKind.fontSize,
                        height: 0.85,
                        color: defectKind.defectColor,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            offset: const Offset(1.0, 1.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
