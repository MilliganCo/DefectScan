import 'history_entry.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntry>> fetchHistory();
  Future<void> addEntry(HistoryEntry entry);
}
