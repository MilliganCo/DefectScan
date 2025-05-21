import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/basket_entity.dart';

const _kStoredBasket = 'current_basket';

class BasketLocalDataSource {
  Future<File> _file(String code) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/basket_$code.json');
  }

  Future<SharedPreferences> get _p async => SharedPreferences.getInstance();

  Future<void> save(BasketEntity b) async {
    final f = await _file(b.productCode);
    await f.writeAsString(jsonEncode(b.toJson()));
    final p = await _p;
    await p.setString(_kStoredBasket, jsonEncode(b.toJson()));
  }

  Future<BasketEntity?> read(String code) async {
    final f = await _file(code);
    if (!await f.exists()) return null;
    final json = jsonDecode(await f.readAsString());
    return BasketEntity.fromJson(json);
  }

  Future<BasketEntity?> load() async {
    final raw = (await _p).getString(_kStoredBasket);
    if (raw == null) return null;
    try {
      return BasketEntity.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null; // на всякий случай
    }
  }

  Future<void> delete(String code) async {
    final f = await _file(code);
    if (await f.exists()) await f.delete();
  }

  Future<void> saveToPrefs(BasketEntity? b) async {
    final p = await _p;
    if (b == null) {
      await p.remove(_kStoredBasket); // очистили корзину
    } else {
      await p.setString(_kStoredBasket, jsonEncode(b.toJson()));
    }
  }

  Future<List<BasketEntity>> getAll() async {
    final dir = await getApplicationDocumentsDirectory();
    final files = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.contains('basket_'));
    return Future.wait(files.map((f) async {
      final json = jsonDecode(await f.readAsString());
      return BasketEntity.fromJson(json);
    }));
  }
}
