// lib/features/history/presentation/history_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/history_entry.dart';
part 'history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default([]) List<HistoryEntry> items,
    @Default(false) bool loading,
    String? error,
  }) = _HistoryState;
}
// The `HistoryState` class represents the state of the history feature in the application.
// It contains a list of `HistoryEntry` items, a loading flag, and an optional error message.