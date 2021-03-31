import 'package:flutter/material.dart';
import 'package:reunionou/Models/Comment.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/User.dart';

class EventCommentForm extends StatefulWidget {
  final Event event;

  EventCommentForm(this.event);

  @override
  _EventCommentFormState createState() => _EventCommentFormState();
}

class _EventCommentFormState extends State<EventCommentForm> {
  final _formKey = GlobalKey<FormState>();
  String content;

  void showMessage(String message, {Function onPressed, String label = "ok"}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: label,
          onPressed: onPressed,
        ),
      ),
    );
  }

  void validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Comment.create(
              User.connectedUser.login, this.widget.event.id, this.content)
          .then((value) {
        if (value != null) {
          Navigator.pop(context);
          showMessage("Comment sent!");
        } else
          showMessage("Comment could not be sent!");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    minLines: 1,
                    maxLines: 100,
                    onSaved: (value) => {this.content = value},
                    initialValue: this.content,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Comment:",
                      labelStyle: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "Please enter a valid comment";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Submit"),
                    onPressed: validateForm,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    /*Container(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              maxLines: 6,
              onSaved: (value) => {this.content = value},
              initialValue: this.content,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: "Comment:",
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) return "Please enter a valid name";
                return null;
              },
            ),
            Padding(
              child: ElevatedButton(
                onPressed: validateForm,
                child: Text("Submit"),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.all(40),
    );*/
  }
}
