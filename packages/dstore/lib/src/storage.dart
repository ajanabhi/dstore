abstract class PersitantStorage {
  Future<void> init();
  bool get isInitialized;
  Future<void> set({required String key, required Map<String, dynamic> json});
  Future<Map<String, dynamic>?> get(String key);
  Future<Map<String, Map<String, dynamic>>?> getState(Iterable<String> keys);
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
