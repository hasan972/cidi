import 'package:cidi/app/data/local/hive_adapter.dart';
import 'package:cidi/app/data/models/item_model.dart';
import 'package:cidi/app/data/models/todo_model.dart';
import 'package:cidi/app/data/services/network_service.dart';
import 'package:cidi/app/routes/app_pages.dart';
import 'package:cidi/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive and register adopters before opening boxes
  await Hive.initFlutter();
  await HiveAdapters().hiveAllAdapterBox();
   Get.put(NetworkService(), permanent: true);
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.initialRoute,
      getPages: AppPages.routes,
    );
  }
}
