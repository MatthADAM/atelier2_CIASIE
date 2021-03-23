import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';

class EventInfo extends StatefulWidget {
  final Event event;

  EventInfo(this.event);

  @override
  _EventInfoState createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: Container(
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
              child: Center(child: Text(this.widget.event.formatDateTime())),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Flexible(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Je participe"),
            ),
          ),
          Flexible(
            child: ElevatedButton(
                onPressed: () {}, child: Text("Je ne viendrais pas")),
          ),
        ],
      ),
    ]);
  }
}
