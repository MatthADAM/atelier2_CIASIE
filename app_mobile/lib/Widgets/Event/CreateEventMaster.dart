import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/User.dart';

class CreateEventMaster extends StatefulWidget {
  @override
  _CreateEventMasterState createState() => _CreateEventMasterState();
}

class _CreateEventMasterState extends State<CreateEventMaster> {
  final _formKey = GlobalKey<FormState>();
  bool private = true;
  DateTime selectedDate;
  String adress = "", name = "";
  int postCode;

  void validateForm() {
    if (this.selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You need to choose a date"),
          action: SnackBarAction(
            label: "ok",
            onPressed: () {},
          ),
        ),
      );
    } else if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Are you sure?"),
          action: SnackBarAction(
            label: "yes",
            onPressed: () {
              Event.create(this.adress, User.connectedUser, this.postCode,
                  !this.private, this.selectedDate, this.name);
            },
          ),
        ),
      );
    }
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
            Row(children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(Icons.calendar_today_outlined),
              ),
              FlatButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2050, 12, 31, 23, 59),
                      onChanged: (date) {}, onConfirm: (date) {
                    setState(() {
                      this.selectedDate = date;
                    });
                    print('confirm $date');
                  }, locale: LocaleType.fr);
                },
                child: Text(
                  this.selectedDate != null
                      ? this.selectedDate.toString()
                      : "Choose a date",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ]),
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
