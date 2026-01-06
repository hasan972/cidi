import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0;
  var count1 = 0;
  var count3 = 0.obs;

  void increment() {
    count++;
    update(['up1']);
  }
   void increment1() {
    count1++;
    update(["up2"]);
  }
   void increment3() {
    count3++;
   
  }
}
