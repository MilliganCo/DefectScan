// lib/core/network/offline_queue.dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'api_client.dart';

class _QueueItem {
  _QueueItem(this.path, this.body);
  final String path;
  final Object body;

  Map<String, dynamic> toJson() => {'path': path, 'body': body};
  static _QueueItem fromJson(Map<String, dynamic> j) =>
      _QueueItem(j['path'] as String, j['body']);
}

class OfflineQueue {
  OfflineQueue(this._api);

  final ApiClient _api;

  Future<Directory> get _dir async {
    final d = await getApplicationDocumentsDirectory();
    final q = Directory('${d.path}/offline_queue');
    if (!await q.exists()) await q.create(recursive: true);
    return q;
  }

  Future<void> add(String path, Object body) async {
    final file =
        File('${(await _dir).path}/${DateTime.now().millisecondsSinceEpoch}.json');
    await file.writeAsString(jsonEncode(_QueueItem(path, body).toJson()));
  }

  Future<void> flush() async {
    final dir = await _dir;
    final files = dir.listSync().whereType<File>();
    for (final f in files) {
      try {
        final j = jsonDecode(await f.readAsString()) as Map<String, dynamic>;
        final item = _QueueItem.fromJson(j);
        await _api.postJson(item.path, item.body);
        await f.delete();
      } catch (_) {
        // сеть всё ещё упала – ждём следующего шанса
        break;
      }
    }
  }
}
// lib/core/network/offline_queue.dart
//  // import 'dart:convert';
//  // import 'dart:io';