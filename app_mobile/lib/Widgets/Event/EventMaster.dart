import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Widgets/Event/EventPreview.dart';

class EventMaster extends StatefulWidget {
  @override
  _EventMasterState createState() => _EventMasterState();
}

class _EventMasterState extends State<EventMaster> {
  final List<Event> events = Event.getSize(0, 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return EventPreview(this.events[index]);
        },
      ),
    );
  }
}
/*
List load while scrolling:

itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            print("generating new words!");
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        }
        */
