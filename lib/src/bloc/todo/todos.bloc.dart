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
  TodoState get initialState => TodoLoading();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
      switch(event.runtimeType){
        case LoadTodo:            yield* executeLoadTodo(event);                break;
        case AddTodo:             yield* executeAddTodo(event);                 break;
        case UpdateTodo:          yield* executeUpdateTodo(event);              break;
        case DeleteTodo:          yield* executeDeleteTodo(event);              break;
        case ToggleAllTodo:       yield* executeToggleAllTodo(event);           break;
        case ClearCompletedTodo:  yield* executeClearCompletedlTodo(event);     break;
      }
  }

  Stream<TodoState> executeLoadTodo(LoadTodo event) async* {
    try {
      final todoList = await this.repository.loadTodoList();
      yield TodoReady(todoList);
    } catch (error) {
      yield TodoFailed(error);
    }
  }

  Stream<TodoState> executeAddTodo(AddTodo event) async* {
    assert (stateIsReady());
    final List<Todo> updatedTodo = List.from((state as TodoReady).todoList)..add(event.todo);
    yield TodoReady(updatedTodo);
    saveTodo(updatedTodo);
  }

  Stream<TodoState> executeUpdateTodo(UpdateTodo event) async* {
    assert (stateIsReady());
    final List<Todo> updatedTodo = (state as TodoReady).todoList.map((todo) => (todo.id == event.todo.id)  ? event.todo : todo ).toList();
    yield TodoReady(updatedTodo);
    saveTodo(updatedTodo);
    
  }

  Stream<TodoState> executeDeleteTodo(DeleteTodo event) async* {
    assert (stateIsReady());
    final updatedTodo = (state as TodoReady).todoList.where((todo) => todo.id != event.todo.id).toList();
    yield TodoReady(updatedTodo);
    saveTodo(updatedTodo);
  }

  Stream<TodoState> executeToggleAllTodo(ToggleAllTodo event) async* {
    assert (stateIsReady());
    final allComplete = (state as TodoReady).todoList.every((todo) => todo.completed);
    final List<Todo> updatedTodo = (state as TodoReady).todoList.map((todo) => todo.copyWith(completed: !allComplete)).toList();
    yield TodoReady(updatedTodo);
    saveTodo(updatedTodo);

  }

  Stream<TodoState> executeClearCompletedlTodo(ClearCompletedTodo event) async* {
    assert (stateIsReady());
    final List<Todo> updatedTodo = (state as TodoReady).todoList.where((todo) => !todo.completed).toList();
    yield TodoReady(updatedTodo);
    saveTodo(updatedTodo);
  }

  Future<void> saveTodo(List<Todo> todoList) {
    return repository.saveTodoList(todoList);
  }

  bool stateIsReady(){
    return (state is TodoReady);
  }
}