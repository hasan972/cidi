import 'package:cidi/app/data/models/item_model.dart';
import 'package:cidi/app/data/models/todo_model.dart';
import 'package:hive/hive.dart';

class HiveAdapters {
  hiveAllAdapterBox() async {
    // Register Adapter for Hove types before opening boxes 
    Hive.registerAdapter(TodoAdapter());
    Hive.registerAdapter(ItemModelAdapter());

    // Open boxes for each type 
    await Hive.openBox<Todo>('todoBox');
    await Hive.openBox<ItemModel>('itemBox');
  }
}
