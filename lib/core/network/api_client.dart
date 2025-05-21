// lib/core/network/api_client.dart
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'offline_queue.dart';

class ApiClient {
  ApiClient(this._baseUrl, [this._queue]);

  final String _baseUrl;
  final OfflineQueue? _queue; // nullable — удобно для тестов / DI

  Future<Map<String, dynamic>> getJson(String path,
      {Map<String, String>? params}) async {
    final uri = Uri.parse('$_baseUrl$path').replace(queryParameters: params);
    final res = await http.get(uri);
    if (res.statusCode != 200) throw ApiException(res.statusCode, res.body);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> postJson(String path, Object body) async {
    final uri = Uri.parse('$_baseUrl$path');
    try {
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (res.statusCode != 200) throw ApiException(res.statusCode, res.body);
      return jsonDecode(res.body) as Map<String, dynamic>;
    } on SocketException {
      // если нет интернета → кладём в очередь и возвращаем условный ответ
      await _queue?.add(path, body);
      return {'status': 'queued'};
    }
  }
}

class ApiException implements Exception {
  ApiException(this.code, this.body);
  final int code;
  final String body;
}
