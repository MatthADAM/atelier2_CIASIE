import 'package:flutter/material.dart';
import 'package:reunionou/Models/User.dart';

class ProfilMaster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 80, bottom: 20),
          child: Center(
              child: Text(
            "Login: " + User.connectedUser.login,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          )),
        ),
        Center(
          child: Text(
            "DisplayName: " + User.connectedUser.displayName,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
