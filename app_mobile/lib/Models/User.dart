import 'package:reunionou/Models/ActionRecord.dart';

class User extends ActionRecord {
  String displayName, login;

  User(String name, login) {
    this.displayName = name;
    this.login = login;
  }
}
