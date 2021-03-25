import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Widgets/Event/EventInfo.dart';
import 'package:reunionou/Widgets/Invitation/ParticipantList.dart';

class EventDetail extends StatelessWidget {
  final Event event;

  EventDetail(this.event);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EventInfo(this.event),
        ParticipantList(this.event),
      ],
    );
  }
}
