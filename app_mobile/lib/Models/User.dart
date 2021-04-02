import 'dart:convert';

import 'package:reunionou/Models/ActionRecord.dart';
import 'package:crypto/crypto.dart';
import 'package:reunionou/Models/UpdatedUser.dart';

class User extends ActionRecord {
  static User connectedUser;
  String displayName, login, password;

  User(this.displayName, this.login, {this.password});

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  static Future<bool> connect(String login, String password) async {
    User user = await User.getByLogin(login, withPwd: true);
    if (user != null) {
      try {
        String hash = user.password;
        if (User.verify(password, hash)) {
          User.connectedUser = user;
          return true;
        }
      } catch (error) {}
    }
    return false;
  }

  static bool verify(String password, String hash) {
    var passHash = User.hashPassword(password);
    passHash = User.hashPassword(passHash);
    return passHash == hash;
  }

  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed
    return sha256.convert(bytes).toString();
  }

  static Future<bool> updateUser(
      String newLogin, String password, String name, String newPassword) async {
    if (User.verify(password, User.connectedUser.password)) {
      UpdatedUser newUser = UpdatedUser(
          name,
          newLogin,
          User.connectedUser.login,
          (newPassword.isEmpty)
              ? User.connectedUser.password
              : User.hashPassword(User.hashPassword(newPassword)));
      dynamic content = await ActionRecord.sendRequest("/api/updateUser",
          method: "POST", object: newUser);
      if (content != null && content is List && content.isNotEmpty) {
        User.connectedUser = User(newLogin, name,
            password: (newPassword.isEmpty)
                ? password
                : User.hashPassword(User.hashPassword(newPassword)));
      } else
        return false;
    } else
      return false;
    return true;
  }

  static Future<User> getByLogin(String login, {bool withPwd = false}) async {
    dynamic content = await ActionRecord.sendRequest("/api/user/" + login);
    User user;
    if (content != null && content is List && content.isNotEmpty) {
      user = User(content[0]["Name"], content[0]["login"],
          password: withPwd ? content[0]["password"] : "");
    }
    return user;
  }
}
