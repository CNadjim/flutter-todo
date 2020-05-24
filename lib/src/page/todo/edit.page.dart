import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/src/model/todo.dart';

class EditPage extends StatefulWidget {
  final Todo todo;
  final Function(String todo) onSave;

  EditPage({
    Key key,
    this.todo,
    this.onSave
  });

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<EditPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edition du todo")
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue:   widget.todo.todo,
                autofocus:      true,
                validator:      (value) =>  value.trim().isEmpty ? "Il manque pas un truc là ?" : null,
                onSaved:        (value) => task = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Sauvegarder",
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(task);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}