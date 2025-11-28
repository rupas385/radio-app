import '../../core/api/api_service.dart';
import '../models/radio_station.dart';

class RadioProvider {
  final ApiService _apiService;

  RadioProvider({required ApiService apiService}) : _apiService = apiService;

  Future<List<RadioStationModel>> getTopStations() async {
    try {
      final response = await _apiService.get('/stations/topclick/20');

      if (response is List) {
        return response.map((json) => RadioStationModel.fromMap(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error getting radios: $e');
    }
  }
}