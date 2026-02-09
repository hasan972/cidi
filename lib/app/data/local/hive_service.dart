import 'package:cidi/app/data/models/todo_model.dart';
import 'package:hive/hive.dart';

class HiveService {
  static const String todoBox = 'todoBox';
  
  static Future<Box<Todo>> openTodoBox() async {
    return await Hive.openBox<Todo>(todoBox);
  }
}
