// lib/features/basket/presentation/basket_drawer.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers.dart';
import '../../history/presentation/excel_view_screen.dart';
import 'basket_notifier.dart';
import '../domain/basket_entity.dart';
import '../domain/basket_row.dart';

class BasketDrawer extends ConsumerWidget {
  const BasketDrawer({super.key});

  bool _readOnly(WidgetRef ref) =>
      ref.watch(basketNotifierProvider).readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state   = ref.watch(basketNotifierProvider);
    final notifier = ref.read(basketNotifierProvider.notifier);
    final basket  = state.basket;
    if (basket == null) return const SizedBox.shrink();

    final ro     = state.readOnly;
    final status = state.status;    // Получаем статус

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // ───────── Заголовок + иконка «сменить завод»
            ListTile(
              isThreeLine: true,
              title: Text(
                basket.productName,
                maxLines: 3,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                'Дата: ${basket.date.toIso8601String().substring(0, 10)}',
              ),
              trailing: ro
                  ? Icon(status?.icon, color: status?.color) // Иконка статуса
                  : IconButton(
                      tooltip: 'Сменить завод',
                      icon: const Icon(Icons.factory_outlined),
                      onPressed: () async {
                        final newFactory = await showModalBottomSheet<int>(
                          context: context,
                          builder: (_) => const _FactorySelectSheet(),
                        );
                        if (newFactory != null && newFactory != basket.factory) {
                          notifier.updateBasket(
                            basket.copyWith(factory: newFactory),
                          );
                        }
                      },
                    ),
            ),
            Text(
              'Завод №${basket.factory}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(height: 4),

            // ───────── Список строк
            Expanded(
              child: ListView.builder(
                itemCount: basket.rows.length,
                itemBuilder: (_, i) {
                  final r = basket.rows[i];

                  // long-press для «другое» с комментом
                  return GestureDetector(
                    onLongPress: () {
                      if (r.defect == 'другое' && r.comment.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title  : const Text('Комментарий'),
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
                      title   : Text(_rowTitle(r)),
                      trailing: Text('${r.qty} шт'),
                      leading : ro
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

            // ───────── Нижние действия
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // XLSX
                  IconButton(
                    icon   : const Icon(Icons.open_in_new),
                    tooltip: 'Просмотр XLSX',
                    onPressed: () {
                      final url =
                          'https://example.com/tmp/${basket.productCode}.xlsx';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExcelViewScreen(url: url),
                        ),
                      );
                    },
                  ),

                  // История (+ badge если readOnly)
                  Stack(
                    children: [
                      IconButton(
                        icon   : const Icon(Icons.history),
                        tooltip: 'История',
                        onPressed: () {
                          Navigator.pop(context);     // закрываем Drawer
                          context.go('/history');     // go_router переход
                        },
                      ),
                      if (ro)
                        const Positioned(
                          right : 6,
                          top   : 6,
                          child : CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.redAccent,
                          ),
                        ),
                    ],
                  ),

                  // Очистить
                  IconButton(
                    icon   : const Icon(Icons.delete_forever_outlined),
                    tooltip: 'Очистить корзину',
                    onPressed: ro
                        ? null
                        : () async {
                            final ok = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title  : const Text('Очистить корзину?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Нет'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Да'),
                                  ),
                                ],
                              ),
                            );
                            if (ok == true) {
                              await notifier.clearBasket();
                              if (context.mounted) context.go('/defects'); // остаёмся в списке дефектов
                            }
                          },
                  ),

                  // Отправить
                  IconButton(
                    icon   : const Icon(Icons.upload_file),
                    tooltip: 'Отправить',
                    onPressed: ro
                        ? null
                        : () => _confirmAndSubmit(context, notifier, basket),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────── Диалог «Общее кол-во» + auto-OK
  Future<void> _confirmAndSubmit(
    BuildContext ctx,
    BasketNotifier notifier,
    BasketEntity   basket,
  ) async {

    final sumDefects = basket.rows.fold<int>(0, (s, e) => s + e.qty);
    int qty = sumDefects; // начальное ↔ минимум

    final ok = await showDialog<bool>(
      context: ctx,
      barrierDismissible: false,
      builder: (_) => StatefulBuilder(
        builder: (dCtx, setST) => AlertDialog(
          title: const Text('Общее кол-во в мешке'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  –  ----------------------------------------------------------------
              IconButton(
                iconSize : 48,
                icon     : const Icon(Icons.remove),
                onPressed: qty > sumDefects
                    ? () => setST(() => qty--)
                    : null,
              ),

              //  число / ручное ввод -----------------------------------------------
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                onPressed: () async {
                  final ctrl = TextEditingController(text: '$qty');
                  final v = await showDialog<int>(
                    context: dCtx,
                    builder: (_) => AlertDialog(
                      title  : const Text('Введите количество'),
                      content: TextFormField(
                        controller   : ctrl,
                        autofocus    : true,
                        keyboardType : TextInputType.number,
                        decoration   : const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: ()=>Navigator.pop(dCtx, null),
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
                    fontSize  : 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              //  +  ----------------------------------------------------------------
              IconButton(
                iconSize : 48,
                icon     : const Icon(Icons.add),
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
              onPressed: qty >= sumDefects
                  ? () => Navigator.pop(dCtx, true)
                  : null, // заблокировано!
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
          productCode : basket.productCode,
          productName : basket.productName,
          factory     : basket.factory,
          date        : DateTime.now(),
          defect      : 'ОК',
          size        : basket.productName.split(' ').last,
          qty         : delta,
          comment     : '',
        ),
      );
    }

    await notifier.submit();

    if (ctx.mounted) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Отправлено!')),
      );
    }
  }

  // ───────── небольшое окно ручного ввода
  Future<int?> _askQtyDialog(BuildContext ctx, int current, int min) async {
    final ctrl = TextEditingController(text: '$current');
    String? error;

    return showDialog<int>(
      context: ctx,
      builder: (_) => StatefulBuilder(
        builder: (dCtx, setSt) => AlertDialog(
          title: const Text('Введите количество'),
          content: TextField(
            controller: ctrl,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
              errorText: error,
            ),
            onChanged: (_) => setSt(() => error = null),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dCtx),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                final v = int.tryParse(ctrl.text.trim());
                if (v == null || v < min) {
                  setSt(() => error = '≥ $min');
                } else {
                  Navigator.pop(dCtx, v);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  // Добавьте функцию для формирования заголовка строки:
  String _rowTitle(BasketRow r) {
    if (r.defect.startsWith('размер')) {
      return '${r.defect.replaceAll(RegExp(r',?\\s*${r.size}\\b'), '')}, ${r.size}';
    }
    return r.defect == 'ОК' ? 'ОК' : '${r.defect} ${r.size}';
  }
}

// ───────── Bottom-sheet выбора завода 1-9
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
