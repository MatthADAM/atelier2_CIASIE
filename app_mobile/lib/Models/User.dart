import 'dart:convert';

import 'package:reunionou/Models/ActionRecord.dart';
import 'package:crypto/crypto.dart';

class User extends ActionRecord {
  static User connectedUser;
  String displayName, login;

  User(this.displayName, this.login);

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  static Future<bool> connect(String login, String password) async {
    dynamic content = await ActionRecord.sendRequest("/api/user/" + login);
    if (content != null && content is List && content.length == 1) {
      try {
        String hash = content[0]["password"].toString();
        if (User.verify(password, hash)) {
          User.connectedUser = User(content[0]["Name"], content[0]["login"]);
          return true;
        }
      } catch (error) {}
    }
    return false;
  }

  static bool verify(String password, String hash) {
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha256.convert(bytes).toString();
    return digest == hash;
  }
}
