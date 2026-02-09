import 'package:cidi/app/data/services/network_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/item_controller.dart';


class ItemListPage extends GetView<ItemController> {
 // final controller = Get.find<ItemController>();
  final network = Get.find<NetworkService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          
          Obx(() => IconButton(
                icon: Icon(
                  network.isOnline.value
                      ? Icons.wifi
                      : Icons.wifi_off,
                ),
                onPressed: () {
                  if (network.isOnline.value) {
                    controller.syncItemsFromApi();
                  } else {
                    Get.snackbar(
                      'Offline',
                      'No internet connection',
                    );
                  }
                },
              ))
        ],
      ),

      body: Column(
        children: [
          // 🔥 OFFLINE BANNER
          Obx(() => network.isOnline.value
              ? const SizedBox()
              : Container(
                  width: double.infinity,
                  color: Colors.red,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'Offline mode – showing cached data',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),

          // 
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.items.isEmpty) {
                return const Center(child: Text('No items found'));
              }

              return ListView.builder(
                // Use the length of the observable items list to determine how many list tiles to build, ensuring that the UI updates reactively whenever the items are loaded from Hive or synced from the API. This allows the ListView to display the correct number of items based on the current state of the items list in the controller.
                itemCount: controller.items.length,
                itemBuilder: (_, i) {
                  final item = controller.items[i];
                  return ListTile(
                    leading: Image.network(
                      item.itemImage,
                      width: 40,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                    title: Text(item.itemName),
                    subtitle: Text('৳ ${item.price}'),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
