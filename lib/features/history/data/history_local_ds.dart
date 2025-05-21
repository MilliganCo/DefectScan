import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/history_entry.dart';

/// ключ, под которым храним массив истории в SharedPreferences
const _kHistoryKey = 'history_list';

class HistoryLocalDataSource {
  Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  /// получить лист (последняя запись – первая)
  Future<List<HistoryEntry>> fetch() async {
    final prefs = await _prefs;
    final raw   = prefs.getString(_kHistoryKey);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => HistoryEntry.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// добавить запись; храним макс 100 штук
  Future<void> save(HistoryEntry entry) async {
    final prefs  = await _prefs;
    final list   = await fetch();
    list.insert(0, entry);
    if (list.length > 100) list.removeRange(100, list.length);
    final raw = jsonEncode(list.map((e) => e.toJson()).toList());
    await prefs.setString(_kHistoryKey, raw);
  }
}
