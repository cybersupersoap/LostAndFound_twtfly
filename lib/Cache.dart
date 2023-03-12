import 'package:shared_preferences/shared_preferences.dart';
/**
 * 存储数据到本地
 */

class Store {
  // static StoreKeys storeKeys;
  final SharedPreferences _store;
  static Future<Store> getInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return Store._internal(preferences);
  }

  Store._internal(this._store);

  getString(String key) async {
    return _store.get(key.toString());
  }

  setString(String key, String value) async {
    return _store.setString(key.toString(), value);
  }

  remove(String key) async {
    return _store.remove(key.toString());
  }
}