import 'package:flutter_todo/src/model/todo.dart';

abstract class TodoEvent {
  const TodoEvent();
}

class LoadTodo extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo(this.todo);

  @override
  String toString() => 'add todo $todo';
}

class UpdateTodo extends TodoEvent {
  final Todo todo;

  const UpdateTodo(this.todo);

  @override
  String toString() => 'update todo $todo';
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  const DeleteTodo(this.todo);

  @override
  String toString() => 'delete todo $todo';
}

class ClearCompletedTodo extends TodoEvent {}

class ToggleAllTodo extends TodoEvent {}

class UpdateTodoFilter extends TodoEvent {
  final TodoFilter filter;

  const UpdateTodoFilter(this.filter);

  @override
  String toString() => 'update todo filter $filter';
}