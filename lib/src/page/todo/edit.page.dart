import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/src/bloc/todo/todo.event.dart';
import 'package:flutter_todo/src/bloc/todo/todos.bloc.dart';
import 'package:flutter_todo/src/model/todo.dart';

class EditPage extends StatefulWidget {
  final Todo todo;

  EditPage({this.todo});

  @override
  EditPageState createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this.controller.text = widget.todo.todo;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edition de la tâche")
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: controller,
                autofocus:      true,
                validator:      (value) => value.trim().isEmpty ? "Il manque pas un truc là ?" : null,
                onChanged: (value) => setState(() => null),
                decoration: InputDecoration(
                    hintText: 'Detail de la tâche',
                    filled: true,
                    suffixIcon: controller.text.isNotEmpty ? IconButton(icon: Icon(Icons.clear), onPressed: () => setState(() => controller.clear())) : null)
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Sauvegarder",
        child: Icon(Icons.check),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            BlocProvider.of<TodoBloc>(context).add(UpdateTodo(Todo().copyWith(id : widget.todo.id, completed: widget.todo.completed, todo: controller.value.text )));
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}