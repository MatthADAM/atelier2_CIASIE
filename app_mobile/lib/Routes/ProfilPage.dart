import 'package:flutter/material.dart';
import 'package:reunionou/Routes/CustomRouter.dart';
import 'package:reunionou/Routes/RouterDrawer.dart';
import 'package:reunionou/Widgets/User/ProfilMaster.dart';

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
            child: ProfilMaster(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CustomRouter.updateUserRoute);
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}
