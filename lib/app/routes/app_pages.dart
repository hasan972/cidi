import 'package:cidi/app/modules/home/binding/home_binding.dart';
import 'package:cidi/app/modules/home/view/home_view.dart';
import 'package:cidi/app/modules/todo/binding/todo_binding.dart';
import 'package:cidi/app/modules/todo/view/todo_view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.initialRoute,
      page: () {
        return HomeView();
      },
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.todo,
      page: () {
        return TodoPage();
      },
      binding: TodoBinding(),
    ),
  ];
}
