import 'package:equatable/equatable.dart';
import 'package:flutter_todo/src/model/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoadInProgress extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<Todo> todoList;

  const TodoLoadSuccess(this.todoList);

  @override
  List<Object> get props => [todoList];

  @override
  String toString() => 'TodoLoadSuccess { todoList: $todoList }';
}

class TodoLoadFailure extends TodoState {}