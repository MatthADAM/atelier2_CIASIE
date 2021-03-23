import 'package:flutter/material.dart';
import 'package:reunionou/Routes/CustomRouter.dart';

class RouterDrawer extends StatelessWidget {
  void verifCurrentRoute(BuildContext context, String route) {
    if (route != ModalRoute.of(context).settings.name) {
      Navigator.pushReplacementNamed(context, route);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[400],
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Text('Menu')),
              decoration: BoxDecoration(
                color: Colors.blue[200],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: ListTile(
                tileColor: Colors.blue[100],
                title: Text('Public events'),
                onTap: () => verifCurrentRoute(context, CustomRouter.homeRoute),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: ListTile(
                tileColor: Colors.blue[100],
                title: Text('Planned events'),
                onTap: () =>
                    verifCurrentRoute(context, CustomRouter.plannedEventRoute),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: ListTile(
                tileColor: Colors.blue[100],
                title: Text('My events'),
                onTap: () =>
                    verifCurrentRoute(context, CustomRouter.myEventsRoute),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: ListTile(
                tileColor: Colors.blue[100],
                title: Text('Profil'),
                onTap: () =>
                    verifCurrentRoute(context, CustomRouter.profilRoute),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: ListTile(
                tileColor: Colors.blue[100],
                title: Text('Log out'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
