import 'package:meta/meta.dart';

abstract class PersitantStorage {
  Future<void> init();
  bool get isInitialized;
  Future<void> set({@required String key, @required Map<String, dynamic> json});
  Future<Map<String, dynamic>> get(String key);
}

enum StorageWriteMode { DISKFIRST, DISKLAST }

class StorageOptions {
  final PersitantStorage storage;
  final StorageWriteMode writeMode;

  StorageOptions(
      {@required this.storage, this.writeMode = StorageWriteMode.DISKLAST});
}
