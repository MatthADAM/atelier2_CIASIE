import 'package:reunionou/Models/ActionRecord.dart';

class UpdatedUser extends ActionRecord {
  String displayName, login, loginAnc, password;

  UpdatedUser(this.displayName, this.login, this.loginAnc, this.password);

  @override
  Map<String, dynamic> toJson() {
    return {
      "loginAnc": this.loginAnc,
      "login": this.login,
      "pwd": this.password,
      "displayName": this.displayName
    };
  }
}
