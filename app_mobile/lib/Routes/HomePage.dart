import 'package:flutter/material.dart';
import 'package:reunionou/Widgets/Event/EventMaster.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Public Events"),
      ),
      body: Column(
        children: [
          Flexible(
            child: EventMaster(),
          ),
        ],
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
