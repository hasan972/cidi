import 'package:cidi/app/modules/items/controller/item_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class ItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ItemController());
  }
}
