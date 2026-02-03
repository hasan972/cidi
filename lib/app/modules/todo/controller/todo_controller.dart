import 'package:cidi/app/data/models/todo_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';


class TodoController extends GetxController {
  late Box<Todo> todoBox;

  var todos = <Todo>[].obs;
  var filteredTodos = <Todo>[].obs;
  var isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    todoBox = Hive.box<Todo>('todoBox');
    loadTodos();
  }

  void loadTodos() {
    final data = todoBox.values.toList();
    todos.value = data;
    filteredTodos.value = data;
  }

  void searchTodo(String query) {
    if (query.isEmpty) {
      filteredTodos.value = todos;
    } else {
      filteredTodos.value = todos
          .where((t) =>
              t.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void addTodo(String title) {
    todoBox.add(Todo(title: title));
    loadTodos();
  }

  void updateTodo(Todo todo, String title) {
    todo.title = title;
    todo.save();
    loadTodos();
  }

  void deleteTodo(Todo todo) {
    todo.delete();
    loadTodos();
  }

  void toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    todo.save();
    loadTodos();
  }
}
