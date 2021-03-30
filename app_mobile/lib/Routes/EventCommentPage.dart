import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Routes/CustomRouter.dart';
import 'package:reunionou/Widgets/Event/EventCommentForm.dart';
import 'package:reunionou/Widgets/Event/EventCommentMaster.dart';

class EventCommentPage extends StatelessWidget {
  final Event event;

  const EventCommentPage(this.event, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(this.event.name),
      ),
      body: EventCommentMaster(this.event),
      backgroundColor: Colors.grey[400],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return EventCommentForm(this.event);
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Event",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment_outlined),
              label: "Comments",
            )
          ],
          currentIndex: 1,
          selectedItemColor: Colors.blue[800],
          onTap: (index) {
            if (index == 0)
              Navigator.popAndPushNamed(context, CustomRouter.eventRoute,
                  arguments: this.event);
          }),
    );
  }
}
