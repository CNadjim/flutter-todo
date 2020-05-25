import 'package:flutter_todo/src/model/todo.dart';

abstract class TodoState {
  const TodoState();
}

class TodoLoading extends TodoState {}

class TodoReady extends TodoState {
  final List<Todo> todoList;
  final List<Todo> filteredTodoList;
  final TodoFilter activeFilter;

  const TodoReady({this.todoList, this.filteredTodoList, this.activeFilter});

  @override
  String toString() => 'TodoReady with total : ${todoList.length} & activeFilter : $activeFilter & filtered total : ${filteredTodoList.length}';
}

class TodoFailed extends TodoState {
  final Error error;

  const TodoFailed(this.error);
}
