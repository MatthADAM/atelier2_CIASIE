import 'package:flutter/material.dart';
import 'package:reunionou/Routes/RouterDrawer.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profil"),
      ),
      drawer: RouterDrawer(),
      body: Column(
        children: [
          Flexible(
            child: Text("to implement"),
          ),
        ],
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
