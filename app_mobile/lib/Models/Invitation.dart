import 'package:reunionou/Models/ActionRecord.dart';
import 'package:reunionou/Models/User.dart';

class Invitation extends ActionRecord {
  User user;
  int status;

  Invitation(User user, int status) {
    this.user = user;
    this.status = status;
  }

  @override
  String toString() {
    return this.user.displayName + this.getStatusString();
  }

  String getStatusString() {
    switch (this.status) {
      case 0:
        return " has been invited!";
      case 1:
        return " will be here!";
      case 2:
        return " wont be here.";
      default:
        return " isn't sure.";
    }
  }
}
