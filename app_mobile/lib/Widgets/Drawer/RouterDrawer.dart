import 'package:flutter/material.dart';
import 'package:reunionou/Models/User.dart';
import 'package:reunionou/Routes/CustomRouter.dart';
import 'package:reunionou/Widgets/Drawer/DrawerTile.dart';

class RouterDrawer extends StatelessWidget {
  void verifCurrentRoute(BuildContext context, String route) {
    Navigator.pushReplacementNamed(context, route);
    /*
    if (route != ModalRoute.of(context).settings.name) {
      Navigator.pushReplacementNamed(context, route);
    } else {
      Navigator.pop(context);
    }*/
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
                color: Colors.blue[400],
              ),
            ),
            DrawerTile(() => verifCurrentRoute(context, CustomRouter.homeRoute),
                'Public events'),
            DrawerTile(
                () =>
                    verifCurrentRoute(context, CustomRouter.plannedEventRoute),
                'Planned events'),
            DrawerTile(
                () => verifCurrentRoute(context, CustomRouter.myEventsRoute),
                'My events'),
            DrawerTile(
                () => verifCurrentRoute(context, CustomRouter.invitationRoute),
                'Invitations'),
            DrawerTile(
                () => verifCurrentRoute(context, CustomRouter.refusedRoute),
                'Refused events'),
            DrawerTile(
                () => verifCurrentRoute(context, CustomRouter.profilRoute),
                'Profil'),
            DrawerTile(() {
              User.connectedUser = null;
              Navigator.pushReplacementNamed(
                  context, CustomRouter.connectionRoute);
            }, 'Log out'),
          ],
        ),
      ),
    );
  }
}
