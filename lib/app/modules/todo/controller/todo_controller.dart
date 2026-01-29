import 'package:cidi/app/data/models/todo_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TodoController extends GetxController {
  late Box<Todo> todoBox;
  var todos = <Todo>[].obs;

  @override
  void onInit() async {
    super.onInit();
    todoBox = await Hive.box<Todo>('todoBox');
    loadTodos();
  }

  void loadTodos() {
    todos.value = todoBox.values.toList();
  }

  void addTodo(String title) {
    final todo = Todo(title: title);
    todoBox.add(todo);
    loadTodos();
  }

  void updateTodo(int index, String title) {
    final todo = todos[index];
    todo.title = title;
    todo.save();
    loadTodos();
  }
  void deleteTodo (int index){
    todos[index].delete();
    loadTodos();
  }
  void toggleTodoStatus(int index){
    todos[index].isDone = !todos[index].isDone;
    todos[index].save();
    loadTodos();
  }

}
