// lib/features/basket/presentation/widgets/counter_stepper.dart
import 'package:flutter/material.dart';

class CounterStepper extends StatelessWidget {
  const CounterStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.disabled = false, // ← новый параметр
  });

  final int value;
  final ValueChanged<int> onChanged;
  final bool disabled;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _bigBtn(
            context,
            icon: Icons.remove,
            // если disabled или value ≤ 1 — блокируем «–»
            onTap: (disabled || value <= 1) ? null : () => onChanged(value - 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              '$value',
              style: Theme.of(context).textTheme.headlineMedium, // крупнее
            ),
          ),
          _bigBtn(
            context,
            icon: Icons.add,
            // если disabled — блокируем «+»
            onTap: disabled ? null : () => onChanged(value + 1),
          ),
        ],
      );

  Widget _bigBtn(
    BuildContext ctx, {
    required IconData icon,
    VoidCallback? onTap,
  }) =>
      Ink(
        decoration: ShapeDecoration(
          color: onTap == null
              ? Theme.of(ctx).disabledColor.withAlpha(51) // заменили withOpacity(.2) на withAlpha(51)
              : Theme.of(ctx).colorScheme.primary,
          shape: const CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(icon, size: 32),        // ← 32 dp вместо 24
          padding: const EdgeInsets.all(20), // ← больше «клик-зона»
          color: Colors.white,
          onPressed: onTap,
        ),
      );
}
