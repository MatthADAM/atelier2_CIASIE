import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/Invitation.dart';
import 'package:reunionou/Routes/CustomRouter.dart';

class FloatingMyEventMenu extends StatefulWidget {
  final Event event;

  FloatingMyEventMenu(this.event);

  @override
  _FloatingMyEventMenuState createState() => _FloatingMyEventMenuState();
}

class _FloatingMyEventMenuState extends State<FloatingMyEventMenu> {
  final _formKey = GlobalKey<FormState>();
  String invitationLogin = "";

  @override
  void setState(VoidCallback fn) {
    if (this.mounted) super.setState(fn);
  }

/*
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: "ok",
          onPressed: () {},
        ),
      ),
    );
  }
*/
  void validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Invitation.send(this.invitationLogin, this.widget.event).then((value) {
        if (value != null) {
          //showMessage("Invitation sent!");
          setState(() {
            this.invitationLogin = "";
          });
        } else {
          //showMessage("Invitation could not be sent!");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      /// both default to 16
      marginEnd: 18,
      marginBottom: 20,
      // animatedIcon: AnimatedIcons.menu_close,
      // animatedIconTheme: IconThemeData(size: 22.0),
      /// This is ignored if animatedIcon is non null
      icon: Icons.menu,
      activeIcon: Icons.menu_open_outlined,
      // iconTheme: IconThemeData(color: Colors.grey[50], size: 30),

      /// The label of the main button.
      // label: Text("Open Speed Dial"),
      /// The active label of the main button, Defaults to label if not specified.
      // activeLabel: Text("Close Speed Dial"),
      /// Transition Builder between label and activeLabel, defaults to FadeTransition.
      // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
      /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
      buttonSize: 56.0,
      visible: true,

      /// If true user is forced to close dial manually
      /// by tapping main button and overlay is not rendered.
      closeManually: false,
      curve: Curves.bounceIn,
      //overlayColor: Colors.black,
      overlayOpacity: 0,
      //onOpen: () => print('OPENING DIAL'),
      //onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      //heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),

      // orientation: SpeedDialOrientation.Up,
      // childMarginBottom: 2,
      // childMarginTop: 2,
      //gradientBoxShape: BoxShape.circle,
      /*gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.black, Colors.white],
      ),*/
      children: [
        SpeedDialChild(
          child: Icon(Icons.delete_forever_rounded),
          backgroundColor: Colors.red,
          labelBackgroundColor: Colors.white,
          label: 'Delete',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            this.widget.event.delete().then((value) {
              Navigator.popAndPushNamed(context, CustomRouter.myEventsRoute);
            });
          },
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.white,
          child: Icon(Icons.mail_outline),
          backgroundColor: Colors.green,
          label: 'Invite',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onSaved: (value) =>
                                      {this.invitationLogin = value},
                                  initialValue: this.invitationLogin,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: "user login",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    labelText: "Login:",
                                    labelStyle: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Please enter a valid login";
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: Text("Send invitation"),
                                  onPressed: validateForm,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          //onLongPress: () => print('THIRD CHILD LONG PRESS'),
        ),
      ],
    );
  }
}
