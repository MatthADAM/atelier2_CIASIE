import 'package:app_mobile/Routes/HomePage.dart';
import 'package:app_mobile/Routes/MyRouter.dart';
import 'package:flutter/material.dart';

class Reunionou extends StatefulWidget {
  @override
  _ReunionouAppState createState() => _ReunionouAppState();
}

class _ReunionouAppState extends State<Reunionou> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: MyRouter.generateRoute,
      //initialRoute: MyRouter.homeRoute, //enabling this bring back the back button
      home: HomePage(),
      title: "Reunionou",
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
