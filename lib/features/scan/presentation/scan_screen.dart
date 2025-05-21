// lib/features/scan/presentation/scan_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../basket/domain/basket_entity.dart';
import '../../basket/domain/basket_row.dart';
import '../../basket/presentation/basket_notifier.dart';
import 'package:fltrdfctscn/providers.dart';
import '../../basket/presentation/basket_drawer.dart';

enum _ConflictAction { back, submit, clear }

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanState();
}

class _ScanState extends ConsumerState<ScanScreen> {
  final _scanner = MobileScannerController();
  bool  _handled = false;
  Timer? _resetTimer;

  @override
  void dispose() {
    _scanner.dispose();
    _resetTimer?.cancel();
    super.dispose();
  }

  Future<void> _exitToDefects(BuildContext ctx) async {
    await _scanner.stop(); // выключаем камеру
    if (ctx.mounted) ctx.go('/defects');
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async { await _exitToDefects(context); return false; },
        child: Scaffold(
          // Убираем drawer чтобы не было тёмного фона
          drawer: null,
          drawerEnableOpenDragGesture: false,

          appBar: AppBar(
            // Заменяем бургер на кнопку "Назад"
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _exitToDefects(context),
            ),
            backgroundColor : Colors.transparent,
            foregroundColor : Theme.of(context).colorScheme.primary,
            elevation: 0,
            actions: [
              // Используем единый контроллер для вспышки
              IconButton(
                icon: const Icon(Icons.flash_on),
                onPressed: () => _scanner.toggleTorch(),
              ),
            ],
          ),

          body: MobileScanner(
            controller: _scanner, // Используем тот же контроллер
            onDetect: (capture) async {
              if (_handled) return;
              final code = capture.barcodes.first.rawValue;
              if (code == null) return;

              // ─── обычная логика скана (тест-товар) ──────────────────────
              _handled = true;
              _resetTimer?.cancel();
              _resetTimer = Timer(const Duration(seconds: 2), () => _handled = false);

              // останавливаем камеру — дальше показываем UI
              await _scanner.stop(); // гасим превью

              // мок-товар, пока нет API
              const productName = 'спорт костюм муж., двухнитка, чёрн., L';

              final factory = await showModalBottomSheet<int>(
                context: context,
                builder: (_) => const _FactorySelectSheet(),
              );

              // Отмена выбора завода → просто пустая корзина
              if (factory == null) { _exitToDefects(context); return; }

              ref.read(basketNotifierProvider.notifier).initBasket(
                BasketEntity(
                  productCode : code,
                  productName : productName,
                  factory     : factory,
                  date        : DateTime.now(),
                  rows        : const [],
                ),
              );

              _exitToDefects(context);
            },
          ),
        ),
      );
}

// ───────────────────────────────────────────────────────────────

class _OpenBasketConflictDialog extends StatelessWidget {
  const _OpenBasketConflictDialog({super.key});

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Корзина уже открыта'),
        content: const Text(
            'Вы начали сбор другой позиции.\n'
            'Отправьте или очистите корзину, прежде чем сканировать новый товар.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _ConflictAction.back),
            child: const Text('Назад'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _ConflictAction.submit),
            child: const Text('Отправить'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _ConflictAction.clear),
            child: const Text('Очистить'),
          ),
        ],
      );
}

/// Универсальное диалог-подтверждение
class _YesNoDialog extends StatelessWidget {
  const _YesNoDialog({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title  : Text(title),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Нет')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Да')),
        ],
      );
}

// ───────── переиспользуемый диалог qty (тот же вид, что в Q-5) ─────────
class _QtyDialog extends StatefulWidget {
  const _QtyDialog({required this.initial, required this.minValue});
  final int initial;
  final int minValue;

  @override
  State<_QtyDialog> createState() => _QtyDialogState();
}
class _QtyDialogState extends State<_QtyDialog> {
  late int qty = widget.initial;
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Общее кол-во в мешке'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 48,
              icon: const Icon(Icons.remove),
              onPressed: qty > widget.minValue
                  ? () => setState(() => qty--)
                  : null,
            ),
            TextButton(
              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24)),
              onPressed: () async {
                final ctrl = TextEditingController(text: '$qty');
                final v = await showDialog<int>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Введите количество'),
                    content: TextFormField(
                      controller: ctrl,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, null), child: const Text('Отмена')),
                      ElevatedButton(
                        onPressed: () {
                          final n = int.tryParse(ctrl.text) ?? qty;
                          Navigator.pop(context, n);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                if (v != null && v >= widget.minValue) setState(() => qty = v);
              },
              child: Text(
                '$qty',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              iconSize: 48,
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => qty++),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: qty >= widget.minValue ? () => Navigator.pop(context, true) : null,
            child: const Text('OK'),
          ),
        ],
      );
}

class _FactorySelectSheet extends StatelessWidget {
  const _FactorySelectSheet();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🆕 подсказка
            Text(
              'Выберите номер завода',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                for (var i = 1; i <= 9; i++)
                  ChoiceChip(
                    label: Text('$i'),
                    selected: false,
                    onSelected: (_) => Navigator.pop(context, i),
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
              ],
            ),
          ],
        ),
      );
}

class BasketState {
  // your existing fields and methods
  final List<BasketRow> rows;

  BasketState({required this.rows});

  bool get isEmpty => rows.isEmpty;
}
