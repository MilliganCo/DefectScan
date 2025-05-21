// lib/features/basket/presentation/widgets/defect_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefectTile extends StatelessWidget {
  const DefectTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.selected,
  });

  final String       title;
  final VoidCallback? onTap;
  final bool         selected;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final icon = SvgPicture.string(
      '''
<svg viewBox="0 0 24 24" stroke="#${primary.value.toRadixString(16).padLeft(8, '0')}" 
     fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
</svg>
''',
      width: 36,
      height: 36,
    );

    return Material(
      elevation: selected ? 6 : 2,
      borderRadius: BorderRadius.circular(12),
      color: selected
          ? primary.withOpacity(.25)
          : primary.withOpacity(.06),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
