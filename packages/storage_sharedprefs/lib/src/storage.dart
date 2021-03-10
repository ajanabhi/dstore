import 'dart:convert';

import "package:dstore/dstore.dart";
import 'package:shared_preferences/shared_preferences.dart';

enum StorageSharedPrefsValueType { json, bytearray }

class StorageSharedPrefs implements PersitantStorage {
  final StorageSharedPrefsValueType valueType;
  late final SharedPreferences _prefs;
  static const _prefix = "_DSTORE_STORAGE_";

  StorageSharedPrefs({this.valueType = StorageSharedPrefsValueType.json});
  @override
  Future get(String key) async {
    dynamic result;
    switch (valueType) {
      case StorageSharedPrefsValueType.json:
        final s = _prefs.getString("$_prefix$key");
        if (s != null) {
          result = jsonDecode(s);
        }
        break;
      case StorageSharedPrefsValueType.bytearray:
        // TODO: Handle this case.
        break;
    }
    return result;
  }

  @override
  Future<Map<String, dynamic>?> getKeys(Iterable<String> keys) async {
    final keysToget = keys.toSet();
    final allKeys = _prefs.getKeys();
    await _removeNotUsedKeys(allKeys, keysToget);
    if (allKeys.isEmpty) {
      return null;
    }
    final result = <String, dynamic>{};
    for (final k in keysToget) {
      result[k] = get(k);
    }
    return result;
  }

  Future _removeNotUsedKeys(Set<String> allKeys, Set<String> newKeys) async {
    final keysToget = newKeys;
    for (final k in allKeys) {
      if (!keysToget.contains(k.replaceAll(_prefix, ""))) {
        await _prefs.remove("$_prefix$k");
      }
    }
  }

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> set({required String key, required value}) async {
    switch (valueType) {
      case StorageSharedPrefsValueType.json:
        await _prefs.setString("$_prefix$key", jsonEncode(value));
        break;
      case StorageSharedPrefsValueType.bytearray:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
}
