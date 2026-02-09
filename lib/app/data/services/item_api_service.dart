import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';
// This service is responsible for fetching items form the API and returning a list of ItemModel instnces to the controller by parsing the API response and converting it into a list of IntemModel objects that the controller can use to update the UI and store in hive for offline access. It also handels the metwork request and response parsing logic, abstracting it away from the controller and providing a clean interface for data retrieval. The controller can call the fetchItems method to get the latest items from the API, and the service will handle the network communication and data transformation.

class ItemApiService {
  Future<List<ItemModel>> fetchItems() async {
    final response = await http.post(
      Uri.parse('https://brightflow.transcombd.com/bll_api/item/item_list'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "cid": "BLL",
        "user_id": "ot0460",
        "user_pass": "1234",
        "app_v": "1.0.0"
      }),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      // Extract the list of brands form the API response, which contains nested items, and then flatten the structure to get a single list of items that can be mapped to ItemModel instances.

      final List brandList = decoded['ret_str']['item_list'];

      // 🔥 FLATTEN BRAND → ITEMS
      return brandList
          .expand((brand) => brand['items'])
          .map<ItemModel>((json) => ItemModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}
