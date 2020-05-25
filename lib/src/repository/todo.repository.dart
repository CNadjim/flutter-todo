import 'package:flutter_todo/src/model/todo.dart';
import 'package:flutter_todo/src/storage/file.storage.dart';

class TodoRepository {
  final FileStorage fileStorage;

  TodoRepository({this.fileStorage});

  Future<List<Todo>> loadTodoList() async {
    return fileStorage.loadTodoList();
  }

  Future<dynamic> saveTodoList(List<Todo> todoList) async {
    return fileStorage.saveTodoList(todoList);
  }
}
