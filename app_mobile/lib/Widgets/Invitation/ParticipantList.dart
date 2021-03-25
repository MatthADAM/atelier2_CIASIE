import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/Invitation.dart';
import 'package:reunionou/Widgets/Invitation/InvitationPreview.dart';

class ParticipantList extends StatefulWidget {
  final Event event;

  ParticipantList(this.event);

  @override
  _ParticipantListState createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  List<Invitation> participants = [];

  @override
  void initState() {
    super.initState();
    Invitation.getByEvent(0, 10, this.widget.event.id).then((value) {
      //print("value received!");
      //print(value);
      setState(() {
        this.participants = value;
        //(value == null) ? Invitation.mock() : value;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void setState(fn) {
    if (this.mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (this.participants != null) {
      if (this.participants.isNotEmpty) {
        return Flexible(
          child: Container(
            child: ListView.builder(
                itemCount: this.participants.length,
                itemBuilder: (context, index) {
                  return InvitationPreview(this.participants[index]);
                }),
          ),
        );
      } else {
        return Center(child: Text("No invitations logs."));
      }
    } else {
      return Center(child: Text("Invitations Logs loading..."));
    }
  }
}
