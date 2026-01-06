import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0;
  var count1 = 0;
  var count3 = 0.obs;
  var count4 = 0.obs;

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
  void increment4() {
    count4++;
   
  }
}
