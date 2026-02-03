import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';

class TodoPage extends GetView<TodoController> {
  //final controller = Get.find<TodoController>();
  final textCtrl = TextEditingController();
  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isSearching.value
            ? TextField(
                controller: searchCtrl,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search todo...',
                  border: InputBorder.none,
                ),
                onChanged: controller.searchTodo,
              )
            : const Text('Hive CRUD')),
        actions: [
          Obx(() => IconButton(
                icon: Icon(controller.isSearching.value
                    ? Icons.close
                    : Icons.search),
                onPressed: () {
                  controller.isSearching.toggle();
                  searchCtrl.clear();
                  controller.searchTodo('');
                },
              ))
        ],
      ),

      body: Obx(() => ListView.builder(
            itemCount: controller.filteredTodos.length,
            itemBuilder: (context, index) {
              final todo = controller.filteredTodos[index];

              return ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration:
                        todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) =>
                      controller.toggleTodoStatus(todo),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      controller.deleteTodo(todo),
                ),
                onTap: () {
                  textCtrl.text = todo.title;
                  Get.defaultDialog(
                    title: "Update Todo",
                    content: TextField(controller: textCtrl),
                    onConfirm: () {
                      controller.updateTodo(todo, textCtrl.text);
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
