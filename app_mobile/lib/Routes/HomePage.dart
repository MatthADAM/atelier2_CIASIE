import 'package:flutter/material.dart';
import 'package:reunionou/Routes/RouterDrawer.dart';
import 'package:reunionou/Widgets/Event/PublicEventMaster.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Public Events"),
      ),
      drawer: RouterDrawer(),
      body: Column(
        children: [
          Flexible(
            child: PublicEventMaster(),
          ),
        ],
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
