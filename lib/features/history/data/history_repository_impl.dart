// lib/features/history/data/history_repository_impl.dart
import '../domain/history_repository.dart';
import '../domain/history_entry.dart';
import 'history_local_ds.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._local);
  final HistoryLocalDataSource _local;

  @override
  Future<List<HistoryEntry>> fetchHistory() => _local.fetch();

  @override
  Future<void> addEntry(HistoryEntry e) => _local.save(e);
}
