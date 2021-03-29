import 'package:flutter/material.dart';
import 'package:reunionou/Models/User.dart';

class ProfilUpdateMaster extends StatefulWidget {
  @override
  _ProfilUpdateMasterState createState() => _ProfilUpdateMasterState();
}

class _ProfilUpdateMasterState extends State<ProfilUpdateMaster> {
  final _formKey = GlobalKey<FormState>();
  String login, password, newPassword, displayName;

  @override
  void initState() {
    this.login = User.connectedUser.login;
    this.displayName = User.connectedUser.displayName;
    super.initState();
  }

  void validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Are you sure"),
          action: SnackBarAction(
            label: "yes",
            onPressed: () {
              User.updateUser(this.login, this.password, this.displayName,
                      this.newPassword)
                  .then((value) {});
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
              onSaved: (value) => {this.login = value},
              initialValue: this.login,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Login",
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
              onSaved: (value) => {this.displayName = value},
              initialValue: this.displayName,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Display Name",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: "Display Name:",
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
              obscureText: true,
              onSaved: (value) => {this.password = value},
              initialValue: "",
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Current password",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: "Current password:",
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) return "Please enter a valid password";
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              onSaved: (value) => {this.displayName = value},
              initialValue: "",
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "New password",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText:
                    "New password (keep empty if you don't want to change it):",
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
              ),
              validator: (value) {
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
    );
  }
}
