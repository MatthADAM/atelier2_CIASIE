import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Widgets/Event/EditEventMaster.dart';

class EventEditPage extends StatelessWidget {
  final Event event;
  EventEditPage(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit event"),
      ),
      body: EditEventMaster(this.event),
      backgroundColor: Colors.grey[400],
    );
  }
}
