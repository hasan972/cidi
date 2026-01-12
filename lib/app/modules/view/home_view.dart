import 'package:cidi/app/modules/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  // final depandency = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX Example')),
      body: Row(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GetBuilder<HomeController>(
                  id: 'up1',
                  builder: (controller) {
                    print('First');
                    return Text(
                      controller.count.toString(),
                      style: TextStyle(fontSize: 40),
                    );
                  },
                ),
                SizedBox(width: 10),
                GetBuilder<HomeController>(
                  id: 'up2',
                  builder: (controller) {
                    print('Second');
                    return Text(
                      controller.count1.toString(),
                      style: TextStyle(fontSize: 40),
                    );
                  },
                ),
                GetX<HomeController>(
                  builder: (controller) {
                    print('Third');
                    return Text(
                      controller.count3.toString(),
                      style: TextStyle(fontSize: 40),
                    );
                  },
                ),
                Obx(
                  (() => Text(
                    controller.count4.toString(),
                    style: const TextStyle(fontSize: 30),
                  )),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: controller.increment,
                child: Text('Increment 1'),
              ),
              ElevatedButton(
                onPressed: controller.increment1,
                child: Text('Increment 2'),
              ),
              ElevatedButton(
                onPressed: controller.increment3,
                child: Text('Increment 3'),
              ),
              ElevatedButton(
                onPressed: controller.increment4,
                child: Text('Increment 4'),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}