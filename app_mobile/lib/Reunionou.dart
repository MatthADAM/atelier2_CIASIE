import 'package:reunionou/Routes/CustomRouter.dart';
import 'package:flutter/material.dart';

class Reunionou extends StatefulWidget {
  @override
  _ReunionouAppState createState() => _ReunionouAppState();
}

class _ReunionouAppState extends State<Reunionou> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: CustomRouter.connectionRoute,
      //home: HomePage(),
      title: "Reunionou",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
