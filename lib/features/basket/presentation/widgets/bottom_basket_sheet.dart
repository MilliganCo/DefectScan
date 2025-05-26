import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers.dart';
import '../../../history/presentation/excel_view_screen.dart';
import '../basket_notifier.dart';
import '../../domain/basket_entity.dart';
import '../../domain/basket_row.dart';

class BottomBasketSheet extends ConsumerStatefulWidget {
  const BottomBasketSheet({
    super.key,
    required this.onExpansionChanged,
    required this.onScanPressed,
  });

  final void Function(bool) onExpansionChanged;
  final VoidCallback onScanPressed;

  @override
  ConsumerState<BottomBasketSheet> createState() => _BottomBasketSheetState();
}

class _BottomBasketSheetState extends ConsumerState<BottomBasketSheet> {
  bool _isExpanded = false;
  static const double _collapsedHeight = 60.0;
  static const double _expandedHeight = 400.0;
  void _toggleExpanded() {
    setState(() => _isExpanded = !_isExpanded);
    widget.onExpansionChanged(_isExpanded);
  }

  // Функция форматирования заголовка строки из basket_drawer.dart
  String _rowTitle(BasketRow r) {
    if (r.defect.startsWith('размер')) {
      return '${r.defect.replaceAll(RegExp(r',?\\s*${r.size}\\b'), '')}, ${r.size}';
    }
    return r.defect == 'ОК' ? 'ОК' : '${r.defect} ${r.size}';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(basketNotifierProvider);
    final basket = state.basket;
    if (basket == null) return const SizedBox.shrink();

    final notifier = ref.read(basketNotifierProvider.notifier);
    final ro = state.readOnly;
    final status = state.status;

    return AnimatedContainer(      duration: const Duration(milliseconds: 300),
      height: _isExpanded ? 360 : 60,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Верхняя панель с иконками
          SizedBox(
            height: _collapsedHeight,
            child: Row(              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Очистить корзину
                IconButton(
                  icon: const Icon(Icons.delete_forever_outlined),
                  tooltip: 'Очистить корзину',
                  onPressed: ro ? null : () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Очистить корзину?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Нет'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Да'),
                          ),
                        ],
                      ),
                    );
                    if (ok == true) {
                      await notifier.clearBasket();
                      if (context.mounted) context.go('/scan');
                    }
                  },
                ),
                // Отправить корзину
                IconButton(
                  icon: const Icon(Icons.upload_file),
                  tooltip: 'Отправить корзину',
                  onPressed: ro ? null : () => _confirmAndSubmit(context, notifier, basket),
                ),
                // История
                IconButton(
                  icon: const Icon(Icons.history),
                  tooltip: 'История',
                  onPressed: () => context.go('/history'),
                ),                // Просмотр XLSX
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  tooltip: 'Просмотр XLSX',
                  onPressed: () {
                    final url = 'https://example.com/tmp/${basket.productCode}.xlsx';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExcelViewScreen(url: url),
                      ),
                    );
                  },
                ),
                // Сканировать
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner_outlined),
                  tooltip: 'Сканировать',
                  onPressed: ro ? null : widget.onScanPressed,
                ),
                // Сменить завод
                IconButton(
                  icon: const Icon(Icons.factory_outlined),
                  tooltip: 'Сменить завод',
                  onPressed: ro ? null : () async {
                    final newFactory = await showModalBottomSheet<int>(
                      context: context,
                      builder: (_) => const _FactorySelectSheet(),
                    );
                    if (newFactory != null && newFactory != basket.factory) {
                      notifier.updateBasket(basket.copyWith(factory: newFactory));
                    }
                  },
                ),
                // Стрелка раскрытия (в конце)
                IconButton(
                  icon: Icon(_isExpanded 
                    ? Icons.keyboard_arrow_down 
                    : Icons.keyboard_arrow_up,
                    color: Colors.black54),
                  onPressed: _toggleExpanded,                ),
              ],
            ),
          ),

          // Раскрывающийся список
          if (_isExpanded) Expanded(
            child: ListView.builder(
              itemCount: basket.rows.length,
              itemBuilder: (_, i) {
                final r = basket.rows[i];
                return GestureDetector(
                  onLongPress: () {
                    if (r.defect.toLowerCase() == 'другое' && r.comment.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Комментарий'),
                          content: Text(r.comment),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: ListTile(
                    title: Text(_rowTitle(r)),
                    trailing: Text('${r.qty} шт'),
                    leading: ro
                      ? const Icon(Icons.remove_red_eye_outlined)
                      : IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => notifier.removeRow(i),
                        ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmAndSubmit(
    BuildContext ctx,
    BasketNotifier notifier,
    BasketEntity basket,
  ) async {
    final sumDefects = basket.rows.fold<int>(0, (s, e) => s + e.qty);
    int qty = sumDefects;

    final ok = await showDialog<bool>(
      context: ctx,
      barrierDismissible: false,
      builder: (_) => StatefulBuilder(
        builder: (dCtx, setST) => AlertDialog(
          title: const Text('Общее кол-во в мешке'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 48,
                icon: const Icon(Icons.remove),
                onPressed: qty > sumDefects ? () => setST(() => qty--) : null,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                onPressed: () async {
                  final ctrl = TextEditingController(text: '$qty');
                  final v = await showDialog<int>(
                    context: dCtx,
                    builder: (_) => AlertDialog(
                      title: const Text('Введите количество'),
                      content: TextFormField(
                        controller: ctrl,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dCtx, null),
                          child: const Text('Отмена'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final n = int.tryParse(ctrl.text) ?? qty;
                            Navigator.pop(dCtx, n);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  if (v != null && v >= sumDefects) setST(() => qty = v);
                },
                child: Text(
                  '$qty',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                iconSize: 48,
                icon: const Icon(Icons.add),
                onPressed: () => setST(() => qty++),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dCtx, false),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: qty >= sumDefects ? () => Navigator.pop(dCtx, true) : null,
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );

    if (ok != true) return;

    // ───── добавляем строку «ОК», если нужно
    final delta = qty - sumDefects;
    if (delta > 0) {
      await notifier.addRow(
        BasketRow(
          productCode: basket.productCode,
          productName: basket.productName,
          factory: basket.factory,
          date: DateTime.now(),
          defect: 'ОК',
          size: basket.productName.split(' ').last,
          qty: delta,
          comment: '',
        ),
      );
    }

    await notifier.submit();

    if (ctx.mounted) {
      Navigator.pop(ctx);
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Отправлено!')),
      );
    }
  }
}

class _FactorySelectSheet extends StatelessWidget {
  const _FactorySelectSheet();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
