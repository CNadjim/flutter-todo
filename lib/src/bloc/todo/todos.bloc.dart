import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/src/bloc/todo/todo.event.dart';
import 'package:flutter_todo/src/bloc/todo/todo.state.dart';
import 'package:flutter_todo/src/model/todo.dart';
import 'package:flutter_todo/src/repository/todo.repository.dart';
import 'package:meta/meta.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc({@required this.repository});

  @override
  TodoState get initialState => TodoLoadInProgress();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    switch(event.runtimeType){
      case TodoLoading:    yield* _mapTodoLoadedToState(); break;
      case TodoAdded:      yield* _mapTodoAddedToState(event); break;
      case TodoUpdated:    yield* _mapTodoUpdatedToState(event); break;
      case TodoDeleted:    yield* _mapTodoDeletedToState(event); break;
      case ToggleAll:      yield* _mapToggleAllToState(); break;
      case ClearCompleted: yield* _mapClearCompletedToState();  break;
    }
  }

  Stream<TodoState> _mapTodoLoadedToState() async* {
    try {
      final todoList = await this.repository.loadTodoList();
      yield TodoLoadSuccess(todoList);
    } catch (e) {
      print(e.toString());
      yield TodoLoadFailure();
    }
  }

  Stream<TodoState> _mapTodoAddedToState(TodoAdded event) async* {
    if (state is TodoLoadSuccess) {
      final List<Todo> updatedTodo = List.from((state as TodoLoadSuccess).todoList)..add(event.todo);
      yield TodoLoadSuccess(updatedTodo);
      _saveTodo(updatedTodo);
    }
  }

  Stream<TodoState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    if (state is TodoLoadSuccess) {
      final List<Todo> updatedTodo = (state as TodoLoadSuccess).todoList.map((todo) => (todo.id == event.todo.id)  ? event.todo : todo ).toList();
      yield TodoLoadSuccess(updatedTodo);
      _saveTodo(updatedTodo);
    }
  }

  Stream<TodoState> _mapTodoDeletedToState(TodoDeleted event) async* {
    if (state is TodoLoadSuccess) {
      final updatedTodo = (state as TodoLoadSuccess).todoList.where((todo) => todo.id != event.todo.id).toList();
      yield TodoLoadSuccess(updatedTodo);
      _saveTodo(updatedTodo);
    }
  }

  Stream<TodoState> _mapToggleAllToState() async* {
    if (state is TodoLoadSuccess) {
      final allComplete = (state as TodoLoadSuccess).todoList.every((todo) => todo.completed);
      final List<Todo> updatedTodo = (state as TodoLoadSuccess).todoList.map((todo) => todo.copyWith(completed: !allComplete)).toList();
      yield TodoLoadSuccess(updatedTodo);
      _saveTodo(updatedTodo);
    }
  }

  Stream<TodoState> _mapClearCompletedToState() async* {
    if (state is TodoLoadSuccess) {
      final List<Todo> updatedTodo = (state as TodoLoadSuccess).todoList.where((todo) => !todo.completed).toList();
      yield TodoLoadSuccess(updatedTodo);
      _saveTodo(updatedTodo);
    }
  }

  Future<void> _saveTodo(List<Todo> todoList) {
    return repository.saveTodoList(todoList);
  }
}