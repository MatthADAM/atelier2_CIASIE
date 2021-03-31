import 'package:flutter/material.dart';
import 'package:reunionou/Widgets/Drawer/RouterDrawer.dart';
import 'package:reunionou/Widgets/Event/StatusEventMaster.dart';

class RefusedEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Refused Events"),
      ),
      drawer: RouterDrawer(),
      body: Column(
        children: [
          Flexible(
            child: StatusEventMaster(2),
          ),
        ],
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
