import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';


class AudioPlayerService extends GetxService {
  late AudioPlayer _player;

  @override
  void onInit() {
    super.onInit();
    _player = AudioPlayer();
  }


  Stream<bool> get isPlayingStream => _player.playingStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  Future<void> play(String url) async {
    try {
      await _player.setUrl(url);
      await _player.play();
    } catch (e) {
      print(e);
      throw Exception("The audio could not be played.");
    }
  }

  Future<void> pause() async => await _player.pause();
  Future<void> resume() async => await _player.play();
  Future<void> stop() async => await _player.stop();
  Future<void> setVolume(double volume) async =>  await _player.setVolume(volume);


  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
}