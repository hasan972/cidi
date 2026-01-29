import 'package:cidi/app/modules/todo/controller/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TodoPage extends StatelessWidget {
  final controller = Get.find<TodoController>();
  final textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive CRUD')),
      body: Obx(() => ListView.builder(
            itemCount: controller.todos.length,
            itemBuilder: (context, index) {
              final todo = controller.todos[index];
              return ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null),
                ),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => controller.toggleTodoStatus(index),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => controller.deleteTodo(index),
                ),
                onTap: () {
                  textCtrl.text = todo.title;
                  Get.defaultDialog(
                    title: "Update Todo",
                    content: TextField(controller: textCtrl),
                    onConfirm: () {
                      controller.updateTodo(index, textCtrl.text);
                      Get.back();
                    },
                  );
                },
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          textCtrl.clear();
          Get.defaultDialog(
            title: "Add Todo",
            content: TextField(controller: textCtrl),
            onConfirm: () {
              controller.addTodo(textCtrl.text);
              Get.back();
            },
          );
        },
      ),
    );
  }
}
