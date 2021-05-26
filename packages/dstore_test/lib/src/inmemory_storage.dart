import 'package:dstore/dstore.dart';

class InMemoryStorage extends PersitantStorage {
  final Map<String, dynamic> initialValues;
  final List<String> errorKeys;
  InMemoryStorage(
      {this.initialValues = const <String, dynamic>{},
      this.errorKeys = const []}) {}
  final prefs = <String, dynamic>{};
  @override
  Future<void> clear() async {
    prefs.clear();
  }

  @override
  Future<void> clearOfflineActions() async {}

  @override
  Future get(String key) async {
    return prefs[key];
  }

  @override
  Future<Map<String, dynamic>?> getKeys(Iterable<String> keys) async {
    return Map<String, dynamic>.fromEntries(
        prefs.entries.where((element) => keys.contains(element.key)));
  }

  @override
  Future<List<Map<String, dynamic>>> getOfflineActions() async {
    return [];
  }

  @override
  Future<String?> getVersion() async {
    return prefs["appVersion"] as String?;
  }

  @override
  Future<void> init() async {
    prefs.addAll(initialValues);
  }

  @override
  Future<void> set({required String key, required dynamic value}) async {
    if (errorKeys.contains(key)) {
      throw GenericStorageError("notable to persist");
    }
    prefs[key] = value;
  }

  @override
  Future<void> setAll(Map<String, dynamic> keyValues) async {}

  @override
  Future<void> setOfflineAction(String key, dynamic value) async {}

  @override
  Future<void> setversion(String appVersion) async {
    prefs["appVersion"] = appVersion;
  }
}
