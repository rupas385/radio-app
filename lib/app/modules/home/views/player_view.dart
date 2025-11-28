import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../data/models/radio_station.dart';
import '../controllers/home_controller.dart';

class PlayerView extends GetView<HomeController> {
  final RadioStationModel station;

  const PlayerView({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 30),
          onPressed: () => Get.back(),
        ),
        actions: [

          Obx(() {
            final isFav = controller.isStationFavorite(station.id);

            return IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(isFav),
                  color: isFav ? Colors.red : Colors.black,
                  size: 28,
                ),
              ),
              onPressed: () => controller.toggleFavorite(station),
            );
          }),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Hero(
              tag: station.id,
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10)
                    )
                  ],
                ),
                child: CachedNetworkImage(
                  imageUrl: station.iconUrl ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.radio, size: 50, color: Colors.grey),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),


            Text(
              station.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "🔴 LIVE BROADCAST",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.0
                ),
              ),
            ),

            const SizedBox(height: 40),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous, size: 40),
                  onPressed: () {},
                ),


                Obx(() {

                  final isCurrent = controller.currentStation.value?.id == station.id;
                  final isPlaying = isCurrent && controller.isPlaying.value;

                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.4),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: IconButton(
                      iconSize: 40,
                      color: Colors.white,
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow_rounded),
                      onPressed: () => controller.playStation(station),
                    ),
                  );
                }),

                IconButton(
                  icon: const Icon(Icons.skip_next, size: 40),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),

            Row(
              children: [
                const Icon(Icons.volume_mute_rounded, color: Colors.grey),
                Expanded(
                  child: Obx(() => Slider(
                    value: controller.volume.value,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Colors.grey[300],
                    onChanged: (v) => controller.changeVolume(v),
                  )),
                ),
                const Icon(Icons.volume_up_rounded, color: Colors.grey),
              ],
            )
          ],
        ),
      ),
    );
  }
}