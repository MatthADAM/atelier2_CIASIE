import 'package:flutter/material.dart';
import 'package:reunionou/Widgets/User/ConnectionForm.dart';

class ConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: ConnectionForm(),
        ),
      ),
    );
  }
}
