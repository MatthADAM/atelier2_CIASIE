import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/User.dart';
import 'package:reunionou/Routes/CustomRouter.dart';
import 'package:reunionou/Widgets/Event/EventDetail.dart';
import 'package:reunionou/Widgets/Invitation/FloatingMyEventMenu.dart';

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
      floatingActionButton: (this.event.owner == User.connectedUser.login)
          ? FloatingMyEventMenu(this.event)
          : Container(),
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
          currentIndex: 0,
          selectedItemColor: Colors.blue[800],
          onTap: (index) {
            if (index == 1)
              Navigator.popAndPushNamed(context, CustomRouter.eventCommentRoute,
                  arguments: this.event);
          }),
    );
  }
}
