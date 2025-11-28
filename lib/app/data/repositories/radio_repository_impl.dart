import '../models/radio_station.dart';
import '../providers/radio_provider.dart';
import '../providers/local_storage_provider.dart';

class RadioRepository {
  final RadioProvider _radioProvider;
  final LocalStorageProvider _localStorageProvider;

  RadioRepository({
    required RadioProvider radioProvider,
    required LocalStorageProvider localStorageProvider,
  })  : _radioProvider = radioProvider,
        _localStorageProvider = localStorageProvider;


  Future<List<RadioStationModel>> getStations() async {

    final apiFuture = _radioProvider.getTopStations();
    final localFuture = _localStorageProvider.getFavoriteIds();


    final results = await Future.wait([apiFuture, localFuture]);

    final stations = results[0] as List<RadioStationModel>;
    final favoriteIds = results[1] as List<String>;


    return stations.map((station) {
      return station.copyWith(
        isFavorite: favoriteIds.contains(station.id),
      );
    }).toList();
  }


  Future<void> toggleFavorite(String id) async {

    final currentFavorites = await _localStorageProvider.getFavoriteIds();

    if (currentFavorites.contains(id)) {
      currentFavorites.remove(id);
    } else {
      currentFavorites.add(id);
    }

    await _localStorageProvider.saveFavoriteIds(currentFavorites);
  }
}