import 'package:equatable/equatable.dart';
import 'package:flutter_todo/src/model/todo.dart';

abstract class TodoState {
  const TodoState();
}

class TodoLoading extends TodoState {}

class TodoReady extends TodoState {
  final List<Todo> todoList;

  const TodoReady(this.todoList);

  @override
  String toString() => 'TodoLoaded { todoList: $todoList }';
}

class TodoFailed extends TodoState {
  final Error error;

  const TodoFailed(this.error);
}