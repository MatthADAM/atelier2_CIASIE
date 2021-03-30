import 'package:flutter/material.dart';
import 'package:reunionou/Routes/CustomRouter.dart';
import 'package:reunionou/Widgets/Drawer/RouterDrawer.dart';
import 'package:reunionou/Widgets/Event/UserEventMaster.dart';

class MyEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Events"),
      ),
      drawer: RouterDrawer(),
      body: Column(
        children: [
          Flexible(
            child: UserEventMaster(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CustomRouter.createEventPage);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
