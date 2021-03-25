import 'package:flutter/material.dart';
import 'package:reunionou/Models/Invitation.dart';

class InvitationPreview extends StatelessWidget {
  Invitation invitation;

  InvitationPreview(this.invitation);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue[400],
          ),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          padding: EdgeInsets.all(5),
          child: Center(
            child: Text(
              this.invitation.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
