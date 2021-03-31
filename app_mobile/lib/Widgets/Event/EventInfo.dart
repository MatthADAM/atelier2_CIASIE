import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/Invitation.dart';
import 'package:reunionou/Models/User.dart';

class EventInfo extends StatefulWidget {
  final Event event;
  final Function updateInvitationStatus;

  EventInfo(this.event, {this.updateInvitationStatus});

  @override
  _EventInfoState createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  Invitation invitation;

  @override
  void setState(fn) {
    if (this.mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    Invitation.getUserEventInvitation(
            User.connectedUser.login, this.widget.event.id)
        .then((value) {
      //print("value received!");
      //print(value);
      setState(() {
        this.invitation = value; //(value == null) ? Event.mock() : value;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
              child: Column(children: [
                Text("Date: " + this.widget.event.formatDateTime()),
                Text("Organisator: " + this.widget.event.owner),
                Text("Adress: " +
                    this.widget.event.adress +
                    " " +
                    this.widget.event.postCode.toString()),
              ]),
            ),
          ),
        ],
      ),
      this.getStatusButtons(),
    ]);
  }

  Widget getStatusButtons() {
    if (this.invitation != null) {
      return Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      this.invitation == null || this.invitation.status != 2
                          ? Colors.green
                          : Colors.grey),
                ),
                onPressed: () {
                  this
                      .invitation
                      .setStatus(1)
                      .then(this.widget.updateInvitationStatus);
                },
                child: Text("I will attempt"),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        (this.invitation == null || this.invitation.status != 1)
                            ? Colors.red
                            : Colors.grey),
                  ),
                  onPressed: () {
                    this
                        .invitation
                        .setStatus(2)
                        .then(this.widget.updateInvitationStatus);
                  },
                  child: Text("I won't attempt")),
              margin: EdgeInsets.all(10),
            ),
          ),
        ],
      );
    } else
      return Container();
  }
}
