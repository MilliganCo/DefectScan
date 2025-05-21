// lib/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/network/api_client.dart';
import 'core/network/connectivity_service.dart';
import 'core/network/offline_queue.dart';
import 'features/basket/data/basket_local_ds.dart';
import 'features/basket/data/basket_remote_ds.dart';
import 'features/basket/data/basket_repository_impl.dart';
import 'features/history/data/history_local_ds.dart';
import 'features/history/data/history_repository_impl.dart';
import 'features/history/domain/history_repository.dart';
import 'features/basket/presentation/basket_notifier.dart';
import 'features/basket/presentation/basket_state.dart';
import 'features/history/presentation/history_notifier.dart';
import 'features/history/presentation/history_state.dart';
import 'features/settings/presentation/settings_notifier.dart';
import 'features/basket/data/basket_session_ds.dart';

// ─────────────────────────────────────────────────────────────
// Connectivity
final connectivityProvider =
    Provider<ConnectivityService>((_) => ConnectivityService.instance);

// Offline-queue
final offlineQueueProvider = Provider<OfflineQueue>((ref) {
  final api = ApiClient('https://api.example.com'); // временный без queue
  final q   = OfflineQueue(api);

  ref.watch(connectivityProvider).stream.listen((s) {
    if (s == NetStatus.online) q.flush();
  });
  return q;
});

// ApiClient с очередью
final apiClientProvider = Provider<ApiClient>((ref) {
  final queue = ref.watch(offlineQueueProvider);
  return ApiClient('https://api.example.com', queue);
});

// ─────────────────────────────────────────────────────────────
// Repositories
final basketRepositoryProvider = Provider((ref) {
  final api = ref.watch(apiClientProvider);
  return BasketRepositoryImpl(
    BasketLocalDataSource(),
    BasketRemoteDataSource(api),
  );
});

// History repo = локальный + remote
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(HistoryLocalDataSource());
});

// ─────────────────────────────────────────────────────────────
// Session-storage provider
final basketSessionProvider = Provider<BasketSessionStorage>(
  (_) => BasketSessionStorage(),
);

// ─────────────────────────────────────────────────────────────
// Repositories & notifiers
final basketNotifierProvider =
    StateNotifierProvider<BasketNotifier, BasketState>((ref) {
  final repo        = ref.watch(basketRepositoryProvider);
  final historyRepo = ref.watch(historyRepositoryProvider);
  final session     = ref.watch(basketSessionProvider);
  return BasketNotifier(repo, historyRepo, session);
});

final historyNotifierProvider =
    StateNotifierProvider<HistoryNotifier, HistoryState>((ref) {
  final repo = ref.watch(historyRepositoryProvider);
  return HistoryNotifier(repo)..load();
});

// Settings
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, int?>((_) => SettingsNotifier());

