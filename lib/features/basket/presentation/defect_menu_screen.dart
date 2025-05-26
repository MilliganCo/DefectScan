// lib/features/basket/presentation/defect_menu_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/basket_row.dart';
import '../presentation/basket_notifier.dart';
import 'widgets/defect_tile.dart';
import 'widgets/bottom_basket_sheet.dart';
import '../../../providers.dart';
import '../../../core/defect_kind.dart';
import 'size_select_screen.dart';

const double controlsHeight = 120.0; // Оптимизированная высота панели управления
const double actionBarHeight = 60.0; // Высота для панели действий внизу
const double expandedListHeight = 180.0; // Высота раскрытого списка корзины


class DefectMenuScreen extends ConsumerStatefulWidget {
  const DefectMenuScreen({super.key});
  @override
  ConsumerState<DefectMenuScreen> createState() => _State();
}

class _State extends ConsumerState<DefectMenuScreen> {
  DefectKind? _selectedDefect;
  String? _pickedSize;
  int _qty = 1;
  bool _isBottomSheetExpanded = false;

  String _getDefectLabel(DefectKind defect) {
    if (defect.label.toLowerCase().contains('размер') && _pickedSize != null) {
      return '${defect.label}, $_pickedSize';
    }
    return defect.label;
  }

  void _onBottomSheetExpansionChanged(bool expanded) {
    setState(() => _isBottomSheetExpanded = expanded);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(basketNotifierProvider);
    final basket = state.basket;
    final notifier = ref.read(basketNotifierProvider.notifier);
    final readOnly = state.readOnly;

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
              ElevatedButton.icon(
                icon: const Icon(Icons.qr_code_scanner_outlined),
                label: const Text('Отсканировать товар'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 14),
                ),
                onPressed: () => context.go('/scan'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.history),
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
    }    // Константы для управления размерами и отступами    const double controlsHeight = 120.0; // Оптимизированная высота панели управления
    const double actionBarHeight = 60.0; // Высота для панели действий внизу
    const double expandedListHeight = 180.0; // Уменьшенная высота раскрытого списка корзины
    
    // Вычисляем текущее смещение для анимации
    final double bottomOffset = _isBottomSheetExpanded ? expandedListHeight : 0.0;

    // Сетка с дефектами
    final defectsGrid = GridView.count(      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8), // Уменьшили отступ сверху и добавили снизу
      crossAxisCount: 3,
      mainAxisSpacing: 12, // Уменьшили отступы между кнопками
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: DefectKind.values.map((defect) {
        return DefectTile(
          defectKind: defect,
          selected: _selectedDefect == defect,
          onTap: readOnly 
              ? null 
              : () => setState(() => _selectedDefect = defect),
        );
      }).toList(),
    );

    // Кнопки управления количеством и добавления в корзину
    final controlsPanel = Container(
      height: controlsHeight,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Счётчик с круглыми кнопками
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[300],
                child: IconButton(
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: readOnly ? null : () => setState(() => _qty > 1 ? _qty-- : null),
                  color: Colors.black87,
                  padding: EdgeInsets.zero,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '$_qty',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: readOnly ? null : () => setState(() => _qty++),
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),          const SizedBox(height: 12), // Уменьшен отступ между кнопками
          // Кнопка добавления дефекта
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (readOnly || _selectedDefect == null)
                  ? null
                  : () async {
                      String? comment = '';
                      if (_selectedDefect == DefectKind.other) {
                        comment = await _askComment(context);
                        if (comment == null) return;
                      }

                      if (_selectedDefect!.label.toLowerCase().contains('размер')) {
                        String currentSize = '';
                        try {
                          currentSize = basket.productName.split(' ').last;
                        } catch (e) {
                          currentSize = 'Unknown';
                        }

                        _pickedSize = await Navigator.push(
                          context,
                          MaterialPageRoute<String>(
                            builder: (_) => SizeSelectScreen(
                              current: currentSize,
                              disabledSize: currentSize,
                            ),
                          ),
                        );
                        if (_pickedSize == null) return;
                      }

                      final row = BasketRow(
                        productCode: basket.productCode,
                        productName: basket.productName,
                        factory: basket.factory,
                        date: basket.date,
                        defect: _selectedDefect!.label,
                        size: _pickedSize ?? basket.productName.split(' ').last,
                        qty: _qty,
                        comment: comment,
                      );
                      notifier.addRow(row);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${_getDefectLabel(_selectedDefect!)} × $_qty добавлено'
                          ),
                          duration: const Duration(milliseconds: 600),
                        ),
                      );
                      setState(() { 
                        _selectedDefect = null; 
                        _pickedSize = null; 
                        _qty = 1; 
                      });
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _selectedDefect == null
                    ? 'ВЫБЕРИТЕ ДЕФЕКТ'
                    : 'ДОБАВИТЬ «${_getDefectLabel(_selectedDefect!)}» × $_qty',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              basket.productName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Дата: ${basket.date.toIso8601String().substring(0, 10)} · Завод №${basket.factory}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),      body: Stack(
        fit: StackFit.expand,
        children: [
          // Основной контейнер с анимацией
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            left: 0,
            right: 0,
            top: 0,
            bottom: controlsHeight + actionBarHeight + bottomOffset,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: defectsGrid,
            ),
          ),

          // Панель управления с анимацией
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            left: 0,
            right: 0,
            bottom: actionBarHeight + bottomOffset,
            child: controlsPanel,
          ),

          // Bottom Sheet с действиями (выше всех)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomBasketSheet(
              onExpansionChanged: _onBottomSheetExpansionChanged,
              onScanPressed: () {
                if (basket.rows.isEmpty) {
                  context.go('/scan');
                } else {
                  _showBasketConflict(context, notifier);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _askComment(BuildContext ctx) async {
    final ctrl = TextEditingController();
    return showDialog<String>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Комментарий'),
        content: TextField(
          controller: ctrl, 
          maxLines: 2,
          autofocus: true
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена')
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text('OK')
          ),
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
