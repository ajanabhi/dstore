import 'dart:convert';

import "package:dstore/dstore.dart";
import 'package:shared_preferences/shared_preferences.dart';

enum StorageSharedPrefsValueType { json, bytearray }

class StorageSharedPrefs implements PersitantStorage<String> {
  final StorageSharedPrefsValueType valueType;
  late final SharedPreferences _prefs;
  static const _prefix = "_DSTORE_STORAGE_";

  static const _version_key = "_DSTORE_APP_VERSION_";

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
      if (k.startsWith(_prefix) &&
          !keysToget.contains(k.substring(_prefix.length))) {
        await _prefs.remove("$_prefix$k");
      }
    }
  }

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> set({required String key, required dynamic value}) async {
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

  @override
  Future<void> setAll(Map<String, dynamic> keyValues) async {
    keyValues.forEach((key, dynamic value) async {
      await set(key: key, value: value);
    });
  }

  @override
  Future<String?> getOfflineActions() {
    // TODO: implement getOfflineActions
    throw UnimplementedError();
  }

  @override
  Future<void> saveOfflineActions(String? actions) {
    // TODO: implement saveOfflineActions
    throw UnimplementedError();
  }

  @override
  Future<String?> getVersion() async {
    return _prefs.getString(_version_key);
  }

  @override
  Future<void> setversion(String appVersion) async {
    await _prefs.setString(_version_key, appVersion);
  }
}
