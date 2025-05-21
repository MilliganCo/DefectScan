import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketExists = ref.watch(basketNotifierProvider).basket != null;

    /// Универсальная большая кнопка
    Widget bigButton(
      String label,
      IconData icon,
      VoidCallback? onTap, // nullable → «серый» когда функции нет
    ) =>
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon : Icon(icon, size: 28),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Text(label, style: const TextStyle(fontSize: 18)),
            ),
            onPressed: onTap,
          ),
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Дефект-СКАН')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bigButton('Сканировать', Icons.qr_code_scanner,
                () => context.go('/scan')),

            const SizedBox(height: 24),

            bigButton('История', Icons.history,
                () => context.go('/history')),

            const SizedBox(height: 24),

            bigButton(
              'Восстановить сессию',
              Icons.playlist_add_check,
              basketExists ? () => context.go('/defects') : null,
            ),
          ],
        ),
      ),
    );
  }
}
