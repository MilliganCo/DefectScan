// lib/features/settings/presentation/settings_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends StateNotifier<int?> {
  SettingsNotifier() : super(null) {
    _load();
  }

  static const _keyFactory = 'last_factory';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt(_keyFactory);
  }

  Future<void> setFactory(int factory) async {
    state = factory;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyFactory, factory);
  }
}
// The `SettingsNotifier` class is a state notifier that manages the settings state.
// It loads the last factory setting from shared preferences and provides a method to set a new factory.