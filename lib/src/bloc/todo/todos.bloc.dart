import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/src/bloc/todo/todo.event.dart';
import 'package:flutter_todo/src/bloc/todo/todo.state.dart';
import 'package:flutter_todo/src/model/todo.dart';
import 'package:flutter_todo/src/repository/todo.repository.dart';
import 'package:flutter_todo/src/storage/file.storage.dart';
import 'package:path_provider/path_provider.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  static final fileStorage = new FileStorage(tag : 'todo', getDirectory :getApplicationDocumentsDirectory);
  static final repository = new TodoRepository(fileStorage: fileStorage);


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
        case UpdateTodoFilter:    yield* executeUpdateTodoFilter(event);        break;
      }
  }

  Stream<TodoState> executeLoadTodo(LoadTodo event) async* {
    try {
      final todoList = await repository.loadTodoList();
      yield TodoReady(todoList : todoList, filteredTodoList : todoList, activeFilter : TodoFilter.ALL);
    } catch (error) {
      yield TodoFailed(error);
    }
  }

  Stream<TodoState> executeAddTodo(AddTodo event) async* {
    assert (stateIsReady());
    final List<Todo> updatedTodoList = List.from((state as TodoReady).todoList)..add(event.todo);
    final TodoFilter activeFilter =  (state as TodoReady).activeFilter;
    yield TodoReady(todoList: updatedTodoList, filteredTodoList: getFilteredList(updatedTodoList, activeFilter), activeFilter: activeFilter );
    saveTodo(updatedTodoList);
  }

  Stream<TodoState> executeUpdateTodo(UpdateTodo event) async* {
    assert (stateIsReady());
    final List<Todo> updatedTodoList = (state as TodoReady).todoList.map((todo) => (todo.id == event.todo.id)  ? event.todo : todo ).toList();
    final TodoFilter activeFilter =  (state as TodoReady).activeFilter;
    yield TodoReady(todoList: updatedTodoList, filteredTodoList: getFilteredList(updatedTodoList, activeFilter), activeFilter: activeFilter );
    saveTodo(updatedTodoList);
    
  }

  Stream<TodoState> executeDeleteTodo(DeleteTodo event) async* {
    assert (stateIsReady());
    final List<Todo> updatedTodoList = (state as TodoReady).todoList.where((todo) => todo.id != event.todo.id).toList();
    final TodoFilter activeFilter =  (state as TodoReady).activeFilter;
    yield TodoReady(todoList: updatedTodoList, filteredTodoList: getFilteredList(updatedTodoList, activeFilter), activeFilter: activeFilter );
    saveTodo(updatedTodoList);
  }

  Stream<TodoState> executeToggleAllTodo(ToggleAllTodo event) async* {
    assert (stateIsReady());
    final isAllCompleted = (state as TodoReady).todoList.every((todo) => todo.completed);
    final List<Todo> updatedTodoList = (state as TodoReady).todoList.map((todo) => todo.copyWith(completed: !isAllCompleted)).toList();
    final TodoFilter activeFilter =  (state as TodoReady).activeFilter;
    yield TodoReady(todoList: updatedTodoList, filteredTodoList: getFilteredList(updatedTodoList, activeFilter), activeFilter: activeFilter );
    saveTodo(updatedTodoList);

  }

  Stream<TodoState> executeClearCompletedlTodo(ClearCompletedTodo event) async* {
    assert (stateIsReady());
    final List<Todo> updatedTodoList = (state as TodoReady).todoList.where((todo) => !todo.completed).toList();
    final TodoFilter activeFilter =  (state as TodoReady).activeFilter;
    yield TodoReady(todoList: updatedTodoList, filteredTodoList: getFilteredList(updatedTodoList, activeFilter), activeFilter: activeFilter );
    saveTodo(updatedTodoList);
  }

  Stream<TodoState> executeUpdateTodoFilter(UpdateTodoFilter event) async*{
    assert (stateIsReady());
    final TodoFilter updatedFilter = event.filter;
    final List<Todo> updatedTodoList = (state as TodoReady).todoList;
    yield TodoReady(todoList: updatedTodoList, filteredTodoList: getFilteredList(updatedTodoList, updatedFilter), activeFilter: updatedFilter );
  }

  Future<void> saveTodo(List<Todo> todoList) async {
    return await repository.saveTodoList(todoList);
  }

  bool stateIsReady(){
    return (state is TodoReady);
  }

  List<Todo> getFilteredList(List<Todo> todoList, TodoFilter filter){
    switch(filter){
      case TodoFilter.ALL: return todoList; break;
      case TodoFilter.COMPLETED: return todoList.where((todo) => todo.completed).toList(); break;
      case TodoFilter.ACTIVE: return todoList.where((todo) => !todo.completed).toList(); break;
      default : return todoList; break;
    }

  }
}