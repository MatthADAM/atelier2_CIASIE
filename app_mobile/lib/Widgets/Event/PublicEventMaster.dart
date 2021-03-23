import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Widgets/Event/EventPreview.dart';

class PublicEventMaster extends StatefulWidget {
  @override
  _PublicEventMasterState createState() => _PublicEventMasterState();
}

class _PublicEventMasterState extends State<PublicEventMaster> {
  final List<Event> events = Event.getSize(0, 10);
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: this.events.length,
        itemBuilder: (context, index) {
          /*if (index.isOdd) return Divider();
          final i = index ~/ 2;
          if (i >= this.events.length) {
            this.events.addAll(Event.getSize(++page, 10));
          }
          return EventPreview(this.events[i]);*/
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
