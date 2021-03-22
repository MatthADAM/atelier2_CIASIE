import 'package:reunionou/Routes/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:reunionou/Routes/MyEventsPage.dart';
import 'package:reunionou/Routes/PlannedEventsPage.dart';
import 'package:reunionou/Routes/ProfilPage.dart';

class MyRouter {
  static const String homeRoute = '/';
  static const String plannedEventRoute = "/planned";
  static const String myEventsRoute = "/myevents";
  static const String profilRoute = "/profil";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => HomePage(), settings: settings);
      case plannedEventRoute:
        return MaterialPageRoute(
            builder: (_) => PlannedEventsPage(), settings: settings);
      case profilRoute:
        return MaterialPageRoute(
            builder: (_) => ProfilPage(), settings: settings);
      case myEventsRoute:
        return MaterialPageRoute(
            builder: (_) => MyEventsPage(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
