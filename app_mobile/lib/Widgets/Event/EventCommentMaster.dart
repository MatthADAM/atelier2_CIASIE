import 'package:flutter/material.dart';
import 'package:reunionou/Models/Comment.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Widgets/Event/EventCommentPreview.dart';

class EventCommentMaster extends StatefulWidget {
  final Event event;

  EventCommentMaster(this.event);

  @override
  _EventCommentMasterState createState() => _EventCommentMasterState();
}

class _EventCommentMasterState extends State<EventCommentMaster> {
  List<Comment> comments = [];

  @override
  void setState(VoidCallback fn) {
    if (this.mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    Comment.getByEvent(this.widget.event.id).then((value) {
      setState(() {
        this.comments = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: RefreshIndicator(
          onRefresh: () {
            return Comment.getByEvent(this.widget.event.id).then((value) {
              setState(() {
                this.comments = value;
              });
            });
          },
          child: ListView.builder(
            itemCount: this.comments.length,
            itemBuilder: (context, index) {
              return EventCommentPreview(comments[index]);
            },
          ),
        ))
      ],
    );
  }
}
