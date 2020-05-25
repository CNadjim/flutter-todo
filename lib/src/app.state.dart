
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/src/bloc/audit.bloc.dart';
import 'package:flutter_todo/src/bloc/todo/todos.bloc.dart';

import 'bloc/todo/todo.event.dart';

class AppState extends StatelessWidget{
  final Widget child;

  AppState({this.child});

  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = AuditBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(create: (context) => TodoBloc()..add(LoadTodo()))
      ],
      child: child,
    );
  }
}