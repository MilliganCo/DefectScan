// lib/features/history/presentation/history_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/history_repository.dart';
import 'history_state.dart';

class HistoryNotifier extends StateNotifier<HistoryState> {
  HistoryNotifier(this._repo) : super(const HistoryState());

  final HistoryRepository _repo;

  Future<void> load() async {
    state = state.copyWith(loading: true, error: null);
    try {
      final list = await _repo.fetchHistory();
      state = state.copyWith(items: list, loading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }
}
// The `HistoryNotifier` class is a state notifier that manages the state of the history feature.
// It provides a method to load the history data from the repository and updates the state accordingly.