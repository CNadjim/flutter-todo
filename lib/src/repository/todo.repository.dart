import 'package:flutter_todo/src/model/todo.dart';
import 'package:flutter_todo/src/storage/file.storage.dart';

class TodoRepository {
  final FileStorage fileStorage;
  TodoRepository({this.fileStorage});

  Future<List<Todo>> loadTodoList() async {
    try {
      return await fileStorage.loadTodoList();
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveTodoList(List<Todo> todoList) async {
    try{
      await fileStorage.saveTodoList(todoList);
    }catch(e){
      throw e;
    }
  }
}
