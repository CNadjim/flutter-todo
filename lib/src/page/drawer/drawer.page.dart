import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}