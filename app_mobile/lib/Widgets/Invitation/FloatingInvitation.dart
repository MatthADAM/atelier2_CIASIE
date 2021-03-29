import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/Invitation.dart';

class FloatingInvitation extends StatefulWidget {
  final Event event;

  FloatingInvitation(this.event);

  @override
  _FloatingInvitationState createState() => _FloatingInvitationState();
}

class _FloatingInvitationState extends State<FloatingInvitation> {
  final _formKey = GlobalKey<FormState>();
  String invitationLogin = "";

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

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
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
                            child: RaisedButton(
                              child: Text("Send invitation"),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  Invitation.send(this.invitationLogin,
                                          this.widget.event)
                                      .then((value) {
                                    if (value != null) {
                                      showMessage("Invitation sent!");
                                      setState(() {
                                        this.invitationLogin = "";
                                      });
                                    } else {
                                      showMessage(
                                          "Invitation could not be sent!");
                                    }
                                  });
                                }
                              },
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
      child: Icon(Icons.mail_outline_outlined),
      backgroundColor: Colors.blue,
    );
  }
}
