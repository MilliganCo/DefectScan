import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/basket_entity.dart';

const _kSessionKey = 'current_basket';

class BasketSessionStorage {
  Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  /// вернуть сохранённую корзину или `null`
  Future<BasketEntity?> load() async {
    final raw = (await _prefs).getString(_kSessionKey);
    if (raw == null) return null;
    try {
      return BasketEntity.fromJson(
        Map<String, dynamic>.from(jsonDecode(raw)),
      );
    } catch (_) {
      // повреждённый JSON → стираем
      await clear();
      return null;
    }
  }

  /// сохранить (перезаписывает)
  Future<void> save(BasketEntity basket) async {
    final prefs = await _prefs;
    await prefs.setString(_kSessionKey, jsonEncode(basket.toJson()));
  }

  /// удалить
  Future<void> clear() async =>
      (await _prefs).remove(_kSessionKey);
}
