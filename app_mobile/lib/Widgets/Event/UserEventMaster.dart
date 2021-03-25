import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/User.dart';
import 'package:reunionou/Widgets/Event/EventPreview.dart';

class UserEventMaster extends StatefulWidget {
  @override
  _UserEventMasterState createState() => _UserEventMasterState();
}

class _UserEventMasterState extends State<UserEventMaster> {
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
    Event.getUserEvents(User.connectedUser.login, 0, 10).then((value) {
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
      if (this.events.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () {
            return Event.getUserEvents(User.connectedUser.login, 0, 10)
                .then((value) {
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
        return Center(child: Text("No events."));
      }
    } else {
      return Center(child: Text("Event loading failed!"));
    }
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
