// lib/features/basket/presentation/empty_basket_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyBasketScreen extends StatelessWidget {
  const EmptyBasketScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Корзина пуста')),
        body: Center(
          child: ElevatedButton.icon(
            icon : const Icon(Icons.qr_code_scanner),
            label: const Text('Отсканировать товар'),
            onPressed: () => context.go('/scan'),
          ),
        ),
      );
}
