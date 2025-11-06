import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_client.dart';
import 'local_storage_item.dart';

class LocalStorageClientSharedPrefsImpl implements LocalStorageClient {
  final SharedPreferences prefs;

  LocalStorageClientSharedPrefsImpl(this.prefs);

  @override
  Future<void> writeData(LocalStorageItem newItem) async {
    await prefs.setString(newItem.key, newItem.value);
  }

  @override
  Future<String?> readData(String key) async {
    return prefs.getString(key);
  }

  @override
  Future<void> deleteData(String key) async {
    await prefs.remove(key);
  }

  @override
  Future<bool> containsKeyData(String key) async {
    return prefs.containsKey(key);
  }

  @override
  Future<List<LocalStorageItem>> readAllData() async {
    return prefs.getKeys()
        .map((k) => LocalStorageItem(key: k, value: prefs.getString(k) ?? ''))
        .toList();
  }

  @override
  Future<void> clearData() async {
    await prefs.clear();
  }
}
