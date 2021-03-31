import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Widgets/Event/EventInfo.dart';
import 'package:reunionou/Widgets/Invitation/ParticipantList.dart';

class EventDetail extends StatefulWidget {
  final Event event;

  EventDetail(this.event);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  void updateInvitationStatus(dynamic content) {
    print("EventDetail:updateInvitationStatus");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EventInfo(this.widget.event,
            updateInvitationStatus: updateInvitationStatus),
        ParticipantList(this.widget.event),
      ],
    );
  }
}
