import 'package:get/get.dart';
import 'package:labhouse/app/core/services/audio_player_service.dart';
import '../../../data/models/radio_station.dart';
import '../../../data/repositories/radio_repository_impl.dart';

class HomeController extends GetxController {


  final RadioRepository repository;
  final AudioPlayerService audioService;

  HomeController({
    required this.repository,
    required this.audioService
  });

  final isLoading = true.obs;
  final errorMessage = RxnString();

  final stations = <RadioStationModel>[].obs;

  final currentStation = Rxn<RadioStationModel>();
  final showFavoritesOnly = false.obs;

  List<RadioStationModel> get displayStations {
    if (showFavoritesOnly.value) {
      return stations.where((s) => s.isFavorite).toList();
    }
    return stations;
  }

  final isPlaying = false.obs;
  final volume = 0.5.obs;

  @override
  void onInit() {
    super.onInit();
    getInitialData();

    audioService.isPlayingStream.listen((playing) {
      isPlaying.value = playing;
    });
  }



  Future<void> getInitialData() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final result = await repository.getStations();
      stations.assignAll(result);

    } catch (e) {
      errorMessage.value = "Error loading stations. Check your connection.";
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> playStation(RadioStationModel station) async {
    try {

      if (currentStation.value?.id == station.id) {
        if (isPlaying.value) {
          await audioService.pause();
        } else {
          await audioService.resume();
        }
      }
      else {
        currentStation.value = station;
        await audioService.play(station.streamUrl);
      }

    } catch (e) {
      Get.snackbar("Error", "This station could not be played.");
      isPlaying.value = false;
    }
  }

  void changeVolume(double value) {
    volume.value = value;
    audioService.setVolume(value);
  }

  bool isStationFavorite(String stationId) {
    final station = stations.firstWhere((s) => s.id == stationId, orElse: () => stations.first);
    return station.isFavorite;
  }



  Future<void> toggleFavorite(RadioStationModel stationParam) async {

    final index = stations.indexWhere((s) => s.id == stationParam.id);
    if (index == -1) return;


    final stationInList = stations[index];


    final newStatus = !stationInList.isFavorite;

    final updatedStation = stationInList.copyWith(isFavorite: newStatus);


    stations[index] = updatedStation;

    if (currentStation.value?.id == stationParam.id) {
      currentStation.value = updatedStation;
    }


    try {
      await repository.toggleFavorite(stationParam.id);
    } catch (e) {

      stations[index] = stationInList;
      if (currentStation.value?.id == stationParam.id) {
        currentStation.value = stationInList;
      }
      Get.snackbar("Error", "Could not save");
    }
  }

  void toggleFilter() {
    showFavoritesOnly.value = !showFavoritesOnly.value;
  }
}