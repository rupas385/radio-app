import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageProvider {

  static const _favoritesKey = 'favorite_station_ids';


  Future<List<String>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }


  Future<bool> saveFavoriteIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_favoritesKey, ids);
  }
}