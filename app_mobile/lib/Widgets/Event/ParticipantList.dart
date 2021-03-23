import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/Invitation.dart';

class ParticipantList extends StatefulWidget {
  final Event event;

  ParticipantList(this.event);

  @override
  _ParticipantListState createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  List<Invitation> participants = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: this.participants.length,
          itemBuilder: (context, index) {
            return Text(this.participants[index].toString());
          }),
    );
  }
}
