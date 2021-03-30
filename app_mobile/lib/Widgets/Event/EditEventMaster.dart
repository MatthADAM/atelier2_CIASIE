import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:reunionou/Models/Event.dart';

class EditEventMaster extends StatefulWidget {
  final Event event;
  EditEventMaster(this.event);

  @override
  _EditEventMasterState createState() => _EditEventMasterState();
}

class _EditEventMasterState extends State<EditEventMaster> {
  final _formKey = GlobalKey<FormState>();
  bool private = true;
  DateTime selectedDate;
  String adress, name;
  int postCode;

  @override
  void initState() {
    super.initState();
    this.private = !this.widget.event.public;
    this.adress = this.widget.event.adress;
    this.name = this.widget.event.name;
    this.postCode = this.widget.event.postCode;
    this.selectedDate = this.widget.event.date;
  }

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
    /*
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (this.selectedDate == null) {
        showMessage("You need to choose a date");
      } else {
        showMessage("Are you sure?", label: "yes", onPressed: () {
          Event.update(this.adress, this.postCode, !this.private,
                  this.selectedDate, this.name)
              .then((value) {
            if (value != null)
              Navigator.restorablePopAndPushNamed(
                  context, CustomRouter.eventRoute,
                  arguments: this.widget.event);
            else
              throw NullThrownError();
          }).catchError((error) {
            showMessage("Could not create event!");
          });
        });
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              onSaved: (value) => {this.name = value},
              initialValue: this.name,
              decoration: InputDecoration(
                icon: Icon(Icons.edit),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "enter event name",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: "Event name:",
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) return "Please enter a valid name";
                return null;
              },
            ),
            TextFormField(
              initialValue: this.adress,
              onSaved: (value) => {this.adress = value},
              decoration: InputDecoration(
                icon: Icon(Icons.home),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "enter adress",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: "Adress:",
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) return "Please enter a valid adress";
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (value) => {this.postCode = int.parse(value)},
              decoration: InputDecoration(
                icon: Icon(Icons.local_post_office_outlined),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "enter postal code",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: "Postal code:",
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) return "Please enter a valid postal code";
                return null;
              },
            ),
            Row(children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: (this.private)
                    ? Icon(Icons.lock)
                    : Icon(Icons.people_alt_rounded),
              ),
              Text(
                "Privacy:",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              Switch(
                value: this.private,
                onChanged: (state) {
                  setState(() {
                    this.private = state;
                  });
                },
              ),
              Text(
                this.private ? "Private" : "Public",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ]),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(Icons.calendar_today_outlined),
                ),
                TextButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      currentTime: this.selectedDate,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2050, 12, 31, 23, 59),
                      onChanged: (date) {},
                      onConfirm: (date) {
                        setState(() {
                          this.selectedDate = date;
                        });
                        print('confirm $date');
                      },
                      locale: LocaleType.fr,
                    );
                  },
                  child: Text(
                    this.selectedDate != null
                        ? this.selectedDate.toString()
                        : "Choose a date",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
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
    );
  }
}
