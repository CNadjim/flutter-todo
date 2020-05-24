import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/src/app.dart';
import 'package:flutter_todo/src/bloc/audit.bloc.dart';
import 'package:flutter_todo/src/bloc/todo/todo.event.dart';
import 'package:flutter_todo/src/bloc/todo/todos.bloc.dart';
import 'package:flutter_todo/src/repository/todo.repository.dart';
import 'package:flutter_todo/src/storage/file.storage.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  BlocSupervisor.delegate = AuditBloc();
  runApp(
    BlocProvider(
      create: (context) {
        return TodoBloc(
          repository: TodoRepository(
            fileStorage: FileStorage(tag : 'todo', getDirectory :getApplicationDocumentsDirectory),
          ),
        )..add(LoadTodo());
      },
      child: App(),
    ),
  );
}