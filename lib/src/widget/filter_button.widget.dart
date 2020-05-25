import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/src/bloc/todo/todo.event.dart';
import 'package:flutter_todo/src/bloc/todo/todo.state.dart';
import 'package:flutter_todo/src/bloc/todo/todos.bloc.dart';
import 'package:flutter_todo/src/model/todo.dart';

class FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      return PopupMenuButton<TodoFilter>(
        onSelected: (selected) =>
            BlocProvider.of<TodoBloc>(context).add(UpdateTodoFilter(selected)),
        itemBuilder: (BuildContext context) => <PopupMenuItem<TodoFilter>>[
          PopupMenuItem<TodoFilter>(
              value: TodoFilter.ALL,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tous"),
                  ((state as TodoReady).activeFilter == TodoFilter.ALL)
                      ? Icon(Icons.check)
                      : SizedBox(width: 0.0)
                ],
              )),
          PopupMenuItem<TodoFilter>(
              value: TodoFilter.ACTIVE,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Actif"),
                  ((state as TodoReady).activeFilter == TodoFilter.ACTIVE)
                      ? Icon(Icons.check)
                      : SizedBox(width: 0.0)
                ],
              )),
          PopupMenuItem<TodoFilter>(
              value: TodoFilter.COMPLETED,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Finis"),
                  ((state as TodoReady).activeFilter == TodoFilter.COMPLETED)
                      ? Icon(Icons.check)
                      : SizedBox(width: 0.0)
                ],
              )),
        ],
        icon: Icon(Icons.filter_list),
      );
    });
  }
}
