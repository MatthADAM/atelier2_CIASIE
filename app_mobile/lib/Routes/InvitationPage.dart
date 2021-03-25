import 'package:flutter/material.dart';
import 'package:reunionou/Routes/RouterDrawer.dart';
import 'package:reunionou/Widgets/Event/StatusEventMaster.dart';

class InvitationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Invitations"),
      ),
      drawer: RouterDrawer(),
      body: Column(
        children: [
          Flexible(
            child: StatusEventMaster(0),
          ),
        ],
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
