import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme.dart';
import 'app_router.dart';

void main() => runApp(const ProviderScope(child: App()));

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);      // ← берём GoRouter из провайдера
    return MaterialApp.router(
      title        : 'ОТК-Сканер',
      theme        : AppTheme.light(),
      routerConfig : router,
    );
  }
}
