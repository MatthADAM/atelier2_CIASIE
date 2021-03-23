import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Widgets/Event/EventDetail.dart';

class EventPage extends StatelessWidget {
  final Event event;

  EventPage(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(this.event.name),
      ),
      body: EventDetail(this.event),
      backgroundColor: Colors.grey[400],
    );
  }
}
