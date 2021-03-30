import 'package:flutter/material.dart';
import 'package:reunionou/Models/Comment.dart';

class EventCommentPreview extends StatelessWidget {
  final Comment comment;

  const EventCommentPreview(this.comment, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(children: [
            Expanded(
              child: Text(
                this.comment.owner + " :",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              this.comment.formatDateTime(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ]),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            this.comment.content,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ]),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[200],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
    );
  }
}
