import 'package:flutter/material.dart';
import 'package:reunionou/Models/User.dart';
import 'package:reunionou/Routes/CustomRouter.dart';

class ConnectionForm extends StatefulWidget {
  @override
  _ConnectionFormState createState() => _ConnectionFormState();
}

class _ConnectionFormState extends State<ConnectionForm> {
  final _formKey = GlobalKey<FormState>();
  String login = "", password = "";

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

  void validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      User.connect(this.login, this.password).then((value) {
        print(value);
        if (value) {
          Navigator.pushReplacementNamed(context, CustomRouter.homeRoute);
        } else {
          showMessage("Wrong login or password!");
          print("wrong password");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[200],
      ),
      margin: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              onSaved: (value) => {this.login = value},
              initialValue: this.login,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "enter login",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: "Login:",
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) return "Please enter a valid login";
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              onSaved: (value) => {this.password = value},
              initialValue: this.password,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "enter password",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: "Password:",
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) return "Please enter a valid password";
                return null;
              },
            ),
            Padding(
              child: ElevatedButton(
                onPressed: validateForm,
                child: Text("Sign in"),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            ),
          ],
        ),
      ),
    );
  }
}
