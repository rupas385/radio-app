import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labhouse/app/modules/home/views/player_view.dart';
import 'package:labhouse/app/modules/home/views/widgets/radio_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Stations'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            width: double.infinity,
            child: Row(
              children: [
                Obx(() => FilterChip(
                  label: const Text('Show Favorites'),
                  selected: controller.showFavoritesOnly.value,
                  onSelected: (bool selected) {
                    controller.toggleFilter();
                  },
                  selectedColor: Colors.redAccent,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: controller.showFavoritesOnly.value ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  avatar: controller.showFavoritesOnly.value
                      ? const Icon(Icons.favorite, size: 18, color: Colors.white)
                      : const Icon(Icons.favorite_border, size: 18),
                )),
              ],
            ),
          ),


          Expanded(
            child: Obx(() {

              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      Text(controller.errorMessage.value!),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: controller.getInitialData,
                        child: const Text("Retry"),
                      )
                    ],
                  ),
                );
              }

              final stationsToShow = controller.displayStations;

              if (stationsToShow.isEmpty) {
                if (controller.showFavoritesOnly.value) {
                  return _buildEmptyFavoritesState();
                } else {
                  return const Center(child: Text("No stations available"));
                }
              }

              return ListView.builder(
                itemCount: stationsToShow.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  final station = stationsToShow[index];

                  return Obx(() {
                    final isPlaying = controller.currentStation.value?.id == station.id &&
                        controller.isPlaying.value;

                    final isFav = station.isFavorite;

                    return RadioCard(
                      station: station,
                      isPlaying: isPlaying,
                      isFavorite: isFav,
                      onTap: () {

                        Get.to(
                              () => PlayerView(station: station),
                          transition: Transition.fadeIn,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      onFavoriteToggle: () => controller.toggleFavorite(station),
                    );
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyFavoritesState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 60, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "No favorites",
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            "Bookmark your stations to view them here",
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}