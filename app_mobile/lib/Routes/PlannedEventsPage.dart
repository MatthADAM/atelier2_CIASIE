import 'package:flutter/material.dart';
import 'package:reunionou/Routes/RouterDrawer.dart';

class PlannedEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Planned Events"),
      ),
      drawer: RouterDrawer(),
      body: Column(
        children: [
          Flexible(
            child: Text("to implement"),
          ),
        ],
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
