import 'package:flutter/material.dart';
import 'package:reunionou/Widgets/User/ProfilUpdateMaster.dart';

class ProfilUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Update Profil"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ProfilUpdateMaster(),
          ),
        ],
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
