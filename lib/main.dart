import 'package:cidi/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: HomeView());
  }
}

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final depandency = Get.put(CounterController());

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
                GetBuilder<CounterController>(
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
                GetBuilder<CounterController>(
                  id: 'up2',
                  builder: (controller) {
                    print('Second');
                    return Text(
                      controller.count1.toString(),
                      style: TextStyle(fontSize: 40),
                    );
                  },
                ),
                GetX<CounterController>(
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
                    depandency.count4.toString(),
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
                onPressed: depandency.increment,
                child: Text('Increment 1'),
              ),
              ElevatedButton(
                onPressed: depandency.increment1,
                child: Text('Increment 2'),
              ),
              ElevatedButton(
                onPressed: depandency.increment3,
                child: Text('Increment 3'),
              ),
              ElevatedButton(
                onPressed: depandency.increment4,
                child: Text('Increment 4'),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          depandency.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
