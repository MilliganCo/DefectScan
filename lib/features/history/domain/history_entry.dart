import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart'; // добавьте для @visibleForTesting
import 'history_status.dart';
import '../../basket/domain/basket_entity.dart';   // для восстановления
import '../../basket/domain/basket_row.dart';      // импорт BasketRow

part 'history_entry.freezed.dart';
part 'history_entry.g.dart';

@freezed
class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required DateTime      date,
    required int           factory,
    required String        productName,
    required int           totalQty,
    required HistoryStatus status,
    required String        fileUrl,
    required List<BasketRow> rows, // ← обязательно!
    String?                productCode,   // ← опционально
    String?                id,            // ← если надо
  }) = _HistoryEntry;

  factory HistoryEntry.fromJson(Map<String,dynamic> json)
      => _$HistoryEntryFromJson(json);
}

// helpers
@visibleForTesting
HistoryStatus _statusFromJson(String s) =>
    s == 'removed' ? HistoryStatus.removed : HistoryStatus.sent;
@visibleForTesting
String _statusToJson(HistoryStatus s) => s.name;
