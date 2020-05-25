import 'dart:convert';
import 'dart:io';

import 'package:flutter_todo/src/model/todo.dart';

class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage({this.tag, this.getDirectory});

  Future<List<Todo>> loadTodoList() async {
    final file = await getLocalFile();
    if(!file.existsSync()){
      await saveTodoList([Todo.empty()]);
    }
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    return json.map<Todo>((todo) => Todo.fromJson(todo)).toList();
  }

  Future<File> saveTodoList(List<Todo> todoList) async {
    final file = await getLocalFile();
    return file.writeAsString(JsonEncoder().convert(todoList.map((todo) => todo.toJson()).toList()));
  }

  Future<File> getLocalFile() async {
    final dir = await getDirectory();
    return File('${dir.path}/$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await getLocalFile();
    return file.delete();
  }
}