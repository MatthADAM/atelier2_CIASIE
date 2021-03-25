import 'package:reunionou/Models/ActionRecord.dart';

class User extends ActionRecord {
  static String connectedUser = "manupatron@gouv.fr";
  String displayName, login;

  User(String name, login) {
    this.displayName = name;
    this.login = login;
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
