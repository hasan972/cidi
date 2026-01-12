import 'package:cidi/app/modules/binding/home_binding.dart';
import 'package:cidi/app/modules/view/home_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static final String initialRoute = '/home';
  static final routs = [

    GetPage(
      name:'/home',
       page: ()=> HomeView(),
       binding: HomeBinding(),
    )
  ];
} 