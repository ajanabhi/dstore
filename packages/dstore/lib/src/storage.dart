abstract class PersitantStorage {
  Future<void> init();
  Future<void> set({required String key, required dynamic value});
  Future<void> setAll(Map<String, dynamic> keyValues);
  Future<dynamic> get(String key);
  Future<Map<String, dynamic>?> getKeys(Iterable<String> keys);
  Future<void> clear();
}

enum StorageWriteMode { DISKFIRST, DISKLAST }

class StorageOptions {
  final PersitantStorage storage;
  final StorageWriteMode writeMode;
  final Function(dynamic error) onWriteError;
  final Function(dynamic error) onReadError;

  StorageOptions(
      {required this.storage,
      required this.onWriteError,
      required this.onReadError,
      this.writeMode = StorageWriteMode.DISKLAST});
}
