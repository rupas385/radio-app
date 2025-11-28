import 'package:get/get.dart';

import '../../../core/api/api_service.dart';
import '../../../core/services/audio_player_service.dart';
import '../../../data/providers/local_storage_provider.dart';
import '../../../data/providers/radio_provider.dart';
import '../../../data/repositories/radio_repository_impl.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => LocalStorageProvider());
    Get.put(AudioPlayerService());
    Get.lazyPut(() => RadioProvider(apiService: Get.find()));
    Get.lazyPut(() => RadioRepository(radioProvider: Get.find(),localStorageProvider: Get.find()));
    Get.lazyPut(() => HomeController(repository: Get.find(), audioService: Get.find()));

  }
}
