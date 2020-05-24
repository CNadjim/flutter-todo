import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/src/model/todo.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Todo todo;

  TodoItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
          color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text("Delete")
            ],
          )
      ),
      secondaryBackground: Container(
          color: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text("Update")
              ]
          )
      ),
      key: Key('dismissible__${todo.id}'),
      confirmDismiss: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: Key('checkbox__${todo.id}'),
          value: todo.completed,
          onChanged: onCheckboxChanged,
        ),
        title: Hero(
          tag: '${todo.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              todo.todo,
              key: Key('${todo.id}__text'),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        )
      ),
    );
  }
}
