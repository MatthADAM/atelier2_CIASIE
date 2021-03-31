import 'package:flutter/material.dart';
import 'package:reunionou/Widgets/Drawer/RouterDrawer.dart';
import 'package:reunionou/Widgets/Event/StatusEventMaster.dart';

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
            child: StatusEventMaster(1),
          ),
        ],
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
