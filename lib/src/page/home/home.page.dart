import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/src/bloc/todo/todo.event.dart';
import 'package:flutter_todo/src/bloc/todo/todo.state.dart';
import 'package:flutter_todo/src/bloc/todo/todos.bloc.dart';
import 'package:flutter_todo/src/model/todo.dart';
import 'package:flutter_todo/src/page/drawer/drawer.page.dart';
import 'package:flutter_todo/src/page/todo/edit.page.dart';
import 'package:flutter_todo/src/widget/filter_button.widget.dart';
import 'package:flutter_todo/src/widget/loading.widget.dart';
import 'package:flutter_todo/src/widget/todo_item.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Todo app par Nadjim"),
          actions: [
            FilterButton()
        ]
      ),
        drawer: DrawerPage(),
      body: BlocBuilder<TodoBloc, TodoState>( builder: (context, state) {
        if(state is TodoReady){
          final todoList = state.filteredTodoList;
          if(todoList.length > 0 ){
            return ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todoList[index];
                  return TodoItem(
                      key: null,
                      todo : todo,
                      onTap: () {
                        BlocProvider.of<TodoBloc>(context).add(UpdateTodo(todo.copyWith(completed: !todo.completed)));
                      },
                      onCheckboxChanged: (value) {
                        BlocProvider.of<TodoBloc>(context).add(UpdateTodo(todo.copyWith(completed: !todo.completed)));
                      },
                      onDismissed: (direction) {
                        if(direction == DismissDirection.endToStart) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)  => EditPage(todo: todo)));
                        }
                        else if(direction == DismissDirection.startToEnd){
                          BlocProvider.of<TodoBloc>(context).add(DeleteTodo(todo));
                        }
                      });
                });
          }
          else{
            return Center(child: Text("Il n'y a rien ici !"));
          }
        }else{
          return LoadingIndicator();
        }
      }),
      floatingActionButton: FloatingActionButton(
        key: null,
        onPressed: () {
          BlocProvider.of<TodoBloc>(context).add(AddTodo(Todo.empty()));
        },
        child: Icon(Icons.add),
        tooltip: "Ajouter un todo",
      )
    );
  }
}