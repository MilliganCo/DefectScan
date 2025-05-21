import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers.dart';
import '../../basket/presentation/basket_notifier.dart';
import '../../basket/domain/basket_entity.dart';
import '../domain/history_status.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state        = ref.watch(historyNotifierProvider);
    final notifier     = ref.read(historyNotifierProvider.notifier);
    final basketNotify = ref.read(basketNotifierProvider.notifier);

    Widget body;
    if (state.loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state.error != null) {
      body = Center(child: Text(state.error!));
    } else {
      final items = state.items;
      body = RefreshIndicator(
        onRefresh: notifier.load,
        child: ListView.builder(
          physics  : const AlwaysScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (_, i) {
            final h = items[i];
            return ListTile(
              leading : Icon(h.status.icon, color: h.status.color),
              title   : Text(
                '${h.date.toIso8601String().substring(0,10)} · '
                'Завод ${h.factory} · ${h.totalQty} шт'),
              subtitle: Text(
                h.productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.open_in_new),
              onTap   : () {
                final b = BasketEntity(
                  productCode : h.productCode ?? '',
                  productName : h.productName,
                  factory     : h.factory,  
                  date        : h.date,
                  rows        : h.rows,
                );
                basketNotify.initBasket(
                  b, 
                  readOnly: true, 
                  status: h.status, // Передаём статус
                );
                context.go('/defects');
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('История'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            basketNotify.exitReadOnly(); // возвращаем рабочую корзину
            context.go('/defects');      // всегда к дефектам
          },
        ),
      ),
      body: body,
    );
  }
}
