import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final Function onTap;
  final String name;
  const DrawerTile(this.onTap, this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      margin: EdgeInsets.all(5),
      child: ListTile(
        tileColor: Colors.blue[100],
        title: Text(this.name),
        onTap: this.onTap,
      ),
    );
  }
}
