import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Widgets/Event/EventPreview.dart';

class StatusEventMaster extends StatefulWidget {
  final int status;

  const StatusEventMaster(this.status, {Key key}) : super(key: key);
  @override
  _StatusEventMasterState createState() => _StatusEventMasterState();
}

class _StatusEventMasterState extends State<StatusEventMaster> {
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
    Event.getStatusEvents(0, 10, this.widget.status).then((value) {
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
      //if (this.events.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () {
          return Event.getStatusEvents(0, 10, this.widget.status).then((value) {
            setState(() {
              this.events = value;
            });
          });
        },
        child: ListView.builder(
          itemCount: this.events.length,
          itemBuilder: (context, index) {
            return EventPreview(this.events[index]);
          },
        ),
      );
    } else {
      return Center(child: Text("Events loading!"));
    }
  }
}
