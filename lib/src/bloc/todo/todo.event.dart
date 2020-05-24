import 'package:equatable/equatable.dart';
import 'package:flutter_todo/src/model/todo.dart';

abstract class TodoEvent {
  const TodoEvent();
}

class LoadTodo extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo(this.todo);

  @override
  String toString() => 'TodoAdded { todo: $todo }';
}

class UpdateTodo extends TodoEvent {
  final Todo todo;

  const UpdateTodo(this.todo);

  @override
  String toString() => 'TodoUpdated { todo: $todo }';
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  const DeleteTodo(this.todo);

  @override
  String toString() => 'TodoDeleted { todo: $todo }';
}

class ClearCompletedTodo extends TodoEvent {}

class ToggleAllTodo extends TodoEvent {}