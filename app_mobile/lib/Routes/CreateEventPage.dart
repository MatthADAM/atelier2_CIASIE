import 'package:flutter/material.dart';
import 'package:reunionou/Widgets/Event/CreateEventMaster.dart';

class CreateEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Create Event"),
        ),
        body: Column(
          children: [
            Flexible(
              child: CreateEventMaster(),
            ),
          ],
        ),
        backgroundColor: Colors.grey[400],
      ),
    );
  }
}
