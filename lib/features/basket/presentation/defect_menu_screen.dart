// lib/features/basket/presentation/defect_menu_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/basket_row.dart';
import '../presentation/basket_notifier.dart';
import 'widgets/defect_tile.dart';
import 'widgets/counter_stepper.dart';
import 'basket_drawer.dart';
import '../../../providers.dart';
import 'size_select_screen.dart';

class DefectMenuScreen extends ConsumerStatefulWidget {
  const DefectMenuScreen({super.key});
  @override
  ConsumerState<DefectMenuScreen> createState() => _State();
}

class _State extends ConsumerState<DefectMenuScreen> {
  static const _defects = [
    'брак верх', 'брак низ', 'брак комплект',
    'размер верх', 'размер низ', 'размер комплект',
    'разноцвет', 'другое', 'ОК',
  ];

  String? _selected;      // название дефекта
  String? _pickedSize;    // выбранный размер (только для «размер …»)
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final state    = ref.watch(basketNotifierProvider);
    final basket   = state.basket;
    final notifier = ref.read(basketNotifierProvider.notifier);
    final readOnly = state.readOnly;

    // ⃣  Корзины ещё нет ─ показываем дружелюбный stub
    if (basket == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Корзина пуста')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Корзина пуста',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              // Кнопка Сканировать
              ElevatedButton.icon(
                icon : const Icon(Icons.qr_code_scanner_outlined),
                label: const Text('Отсканировать товар'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 14),
                ),
                onPressed: () => context.go('/scan'),
              ),
              const SizedBox(height: 12),
              // Новая кнопка История
              OutlinedButton.icon(
                icon : const Icon(Icons.history),
                label: const Text('История'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 14),
                ),
                onPressed: () => context.go('/history'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      drawer: const BasketDrawer(),
      appBar: AppBar(
        title: Text(basket.productName, maxLines: 3),
        leading: Builder(
          builder: (c) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(c).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_outlined),
            onPressed: readOnly
                ? null
                : () {
                    if (basket == null || basket.rows.isEmpty) {
                      context.go('/scan');
                    } else {
                      _showBasketConflict(context, notifier);
                    }
                  },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ───── сетка дефектов
            Expanded(
              child: GridView.builder(
                physics     : const BouncingScrollPhysics(),
                itemCount   : _defects.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount : 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (_, i) {
                  final d = _defects[i];
                  return DefectTile(
                    title   : d,
                    selected: _selected == d,
                    onTap   : readOnly
                        ? null
                        : () async {
                            setState(() {
                              _selected   = d;
                              _pickedSize = null; // сбрасываем прошлый выбор
                              _qty        = 1;
                            });

                            // если «размер …» → открываем диалог размеров
                            if (d.startsWith('размер')) {
                              final scannedSize = basket.productName.split(' ').last;
                              final sz = await Navigator.push<String>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SizeSelectScreen(
                                    current      : scannedSize,
                                    disabledSize : scannedSize, // ← блокируем «родной» размер
                                  ),
                                ),
                              );
                              if (sz != null) {
                                setState(() => _pickedSize = sz);
                              } else {
                                setState(() => _selected = null);
                              }
                            }
                          },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // ───── счётчик
            CounterStepper(
              value    : _qty,
              disabled : readOnly,
              onChanged: (v) => setState(() => _qty = v),
            ),
            const SizedBox(height: 20),

            // ───── большая кнопка
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (readOnly || _selected == null)
                    ? null
                    : () async {
                        // «другое» → комментарий
                        String? comment = '';
                        if (_selected == 'другое') {
                          comment = await _askComment(context);   // null ⇔ Нажали «Отмена»
                          if (comment == null) return;           // 🚫 выходим БЕЗ добавления
                        }

                        final row = BasketRow(
                          productCode : basket.productCode,
                          productName : basket.productName,
                          factory     : basket.factory,
                          date        : basket.date,
                          defect      : _selected!,
                          size        : _pickedSize ?? basket.productName.split(' ').last,
                          qty         : _qty,
                          comment     : comment,
                        );
                        notifier.addRow(row);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content : Text('${row.defect}${row.defect.startsWith('размер') ? ', ${row.size}' : ''} × $_qty добавлено'),
                            duration: const Duration(milliseconds: 600),
                          ),
                        );
                        setState(() { _selected = null; _pickedSize = null; _qty = 1; });
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    _selected == null
                        ? 'ВЫБЕРИТЕ ДЕФЕКТ'
                        : _selected!.startsWith('размер') && _pickedSize != null
                            ? 'ДОБАВИТЬ «$_selected, $_pickedSize» × $_qty'
                            : 'ДОБАВИТЬ «$_selected» × $_qty',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _askComment(BuildContext ctx) async {
    final ctrl = TextEditingController();
    return showDialog<String>(
      context: ctx,
      builder: (_) => AlertDialog(
        title  : const Text('Комментарий'),
        content: TextField(controller: ctrl, maxLines: 2, autofocus: true),
        actions: [
          TextButton  (onPressed: () => Navigator.pop(ctx), child: const Text('Отмена')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, ctrl.text.trim()), child: const Text('OK')),
        ],
      ),
    );
  }

  Future<void> _showBasketConflict(BuildContext context, BasketNotifier notifier) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: const Text('Корзина уже открыта'),
        content: const Text('Сначала завершите или очистите текущую корзину.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
