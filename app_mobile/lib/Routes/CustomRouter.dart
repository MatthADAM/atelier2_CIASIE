import 'package:reunionou/Models/User.dart';
import 'package:reunionou/Routes/ConnectionPage.dart';
import 'package:reunionou/Routes/CreateEventPage.dart';
import 'package:reunionou/Routes/EventPage.dart';
import 'package:reunionou/Routes/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:reunionou/Routes/InvitationPage.dart';
import 'package:reunionou/Routes/MyEventsPage.dart';
import 'package:reunionou/Routes/PlannedEventsPage.dart';
import 'package:reunionou/Routes/ProfilPage.dart';
import 'package:reunionou/Routes/RefusedEventPage.dart';

class CustomRouter {
  static const String homeRoute = '/';
  static const String plannedEventRoute = "/event/accepted";
  static const String myEventsRoute = "/myevents";
  static const String profilRoute = "/profil";
  static const String eventRoute = "/event";
  static const String invitationRoute = "/event/invited";
  static const String createEventPage = "/event/create";
  static const String refusedRoute = "/event/refused";
  static const String connectionRoute = "/connection";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (User.connectedUser != null && settings.name != connectionRoute) {
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
        case eventRoute:
          return MaterialPageRoute(
              builder: (_) => EventPage(settings.arguments),
              settings: settings);
        case invitationRoute:
          return MaterialPageRoute(
              builder: (_) => InvitationPage(), settings: settings);
        case createEventPage:
          return MaterialPageRoute(
              builder: (_) => CreateEventPage(), settings: settings);
        case refusedRoute:
          return MaterialPageRoute(
              builder: (_) => RefusedEventPage(), settings: settings);
        default:
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                        child: Text('No route defined for ${settings.name}')),
                  ));
      }
    } else {
      return MaterialPageRoute(
          builder: (_) => ConnectionPage(), settings: settings);
    }
  }
}
