// lib/app_router.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/scan/presentation/scan_screen.dart';
import 'features/basket/presentation/defect_menu_screen.dart';
import 'features/history/presentation/history_screen.dart';
import 'providers.dart';

// маленький listenable без rxdart
class _StreamNotifier extends ChangeNotifier {
  _StreamNotifier(Stream<dynamic> s) {
    _sub = s.listen((_) => notifyListeners());
  }
  late final StreamSubscription _sub;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final basket = ref.watch(basketNotifierProvider.notifier);

  return GoRouter(
    refreshListenable: _StreamNotifier(basket.stream),
    initialLocation: '/defects',

    redirect: (_, state) {
      final rowsExist = basket.state.basket?.rows.isNotEmpty ?? false;
      final loc       = state.matchedLocation;

      // «/» (или пустой deep-link) → /defects
      if (loc == '/' || loc.isEmpty) return '/defects';

      // Сканер разрешён ТОЛЬКО если в корзине нет позиций
      if (rowsExist && loc == '/scan') return '/defects';

      // Больше никаких автопереходов
      return null;
    },

    routes: [
      GoRoute(
        path: '/defects',
        pageBuilder: (_, __) =>
            const NoTransitionPage(child: DefectMenuScreen()),
      ),
      GoRoute(
        path: '/scan',
        pageBuilder: (_, __) =>
            const NoTransitionPage(child: ScanScreen()),
      ),
      GoRoute(
        path: '/history',
        pageBuilder: (_, __) =>
            const NoTransitionPage(child: HistoryScreen()),
      ),
    ],
  );
});
