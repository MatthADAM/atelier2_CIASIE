import 'package:reunionou/Models/ActionRecord.dart';
import 'package:reunionou/Models/User.dart';

class Invitation extends ActionRecord {
  User user;
  int status;

  Invitation(User user, int status) {
    this.user = user;
    this.status = status;
  }
}
