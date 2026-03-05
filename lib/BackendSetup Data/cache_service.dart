import 'package:hive/hive.dart';

class CacheService {

  static final box = Hive.box('cacheBox');

  static void saveData(String key, dynamic data) {
    box.put(key, data);
  }

  static dynamic getData(String key) {
    return box.get(key);
  }
}