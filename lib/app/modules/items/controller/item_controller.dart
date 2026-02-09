import 'package:cidi/app/data/models/item_model.dart';
import 'package:cidi/app/data/services/item_api_service.dart';
import 'package:cidi/app/data/services/network_service.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ItemController extends GetxController{
  // Hive box for storing ItemModel instances locally, allowing for offline access and persistence of data across app sessions. The box is initialized in the onInit method and is used to load items from local storage and sync with the API when online.
  late Box<ItemModel> itemBox;
  // Service for fetching item data from the API
  final api = ItemApiService();
  // Nrtwork service to monitor online/offline status
  final network = Get.find<NetworkService>();
  // observabe list fo ItemModel instance to update the UI reactively when items are loaded or synced
  var items = <ItemModel>[].obs;
  // Observable boolean to indicate loading state during data sync operations
  var isLoading = false.obs;

  @override
  void onInit(){
    super.onInit();
    // Initialize the Hive box for itemModels and load item data from local storage. Also, set up a listener to automatically sync with the API when the network status changes to online, ensuring that the app always has the latest data when connectivity is available.
    itemBox = Hive.box<ItemModel>('itemBox');
    // Load items from Hive on initialization to ensure that the app can display cached data immediately, even before attempting to sync with the API. This provides a better user experience by showing available data while waiting for network operations to complete.
    loadItemsFromHive();
      ever(network.isOnline, (bool online) {
      if (online) {
        //
        syncItemsFromApi();
      }
    });

    if (network.isOnline.value) {
      syncItemsFromApi();
    }
  }

  void loadItemsFromHive(){
    items.value = itemBox.values.toList();
  }
Future<void> syncItemsFromApi() async {
  try {
    isLoading.value = true;
    // Fetch items from the API and update the Hive box with the latest data. This method first retrieves the latest items from the API, then clears the existing items in the Hive box and adds the new items. Finally, it reloads the items from Hive to update the UI with the latest data. If any errors occur during this process, it catches the exception and falls back to loading items from Hive to ensure that the app can still display data even if the API sync fails.

    final List<ItemModel> apiItems =
        await api.fetchItems(); // ✅ NOT VOID

    await itemBox.clear();

    for (final item in apiItems) {
      await itemBox.add(item);
    }
// 
    loadItemsFromHive();
  } catch (e) {
    print('SYNC ERROR: $e');
    loadItemsFromHive(); // offline fallback
  } finally {
    isLoading.value = false;
  }
}


}