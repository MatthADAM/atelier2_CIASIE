import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Widgets/Event/EventPreview.dart';

class PublicEventMaster extends StatefulWidget {
  @override
  _PublicEventMasterState createState() => _PublicEventMasterState();
}

class _PublicEventMasterState extends State<PublicEventMaster> {
  List<Event> events = [];
  bool loading = true;
  int page = 0;

  @override
  void setState(fn) {
    if (this.mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    Event.getPublicEvents(0, 10).then((value) {
      //print("value received!");
      //print(value);
      setState(() {
        this.events = value; //(value == null) ? Event.mock() : value;
        this.loading = false;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.events != null) {
      return RefreshIndicator(
        onRefresh: () {
          return Event.getPublicEvents(0, 10).then((value) {
            setState(() {
              this.events = value;
            });
          });
        },
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
    } else {
      return Center(child: Text("Events loading!"));
    }
  }
}
