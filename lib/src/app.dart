import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/src/app.route.dart';
import 'package:flutter_todo/src/bloc/todo/todo.event.dart';
import 'package:flutter_todo/src/page/home/home.page.dart';
import 'package:flutter_todo/src/page/todo/edit.page.dart';

import 'bloc/todo/todos.bloc.dart';
import 'model/todo.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Todo app", theme: ThemeData.dark(), routes: {
      AppRoute.home: (context) {
        return HomePage();
      },
      AppRoute.edit: (context) {
        return EditPage(
            key: null,
            onSave: (todo) {
              BlocProvider.of<TodoBloc>(context).add(
                  UpdateTodo(Todo(todo: todo))
              );
            });
      }
    });
  }
}
