import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';

class EventPreview extends StatelessWidget {
  final Event event;

  EventPreview(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[200],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Text(this.event.name),
          ),
          Expanded(
            child: Text(this.event.date.toString()),
          ),
        ],
      ),
    );
  }
}
