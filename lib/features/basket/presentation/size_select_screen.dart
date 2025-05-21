// lib/features/basket/presentation/size_select_screen.dart
import 'package:flutter/material.dart';

class SizeSelectScreen extends StatelessWidget {
  const SizeSelectScreen({
    super.key,
    required this.current,
    required this.disabledSize,    // ← new
  });

  final String current;
  final String disabledSize;       // ← new

  static const _sizes = [
    '3XS', '2XS', 'XS',
    'S',   'M',   'L',
    'XL',  '2XL', '3XL',
    '4XL', '5XL',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбор размера')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: _sizes.length + 1, // +1 for the «back» tile
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, i) {
            if (i == _sizes.length) {
              return InkWell(
                onTap: () => Navigator.pop<String?>(context, null),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_back, size: 32),
                  ),
                ),
              );
            }

            final size = _sizes[i];
            final isCurrent = size == current;
            final isDisabled = size == disabledSize; // дизаблим disabledSize

            return InkWell(
              onTap: isDisabled
                  ? null
                  : () => Navigator.pop<String>(context, size),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: isDisabled
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    size,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isDisabled
                          ? Theme.of(context).colorScheme.onSurface.withOpacity(0.4)
                          : null,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
