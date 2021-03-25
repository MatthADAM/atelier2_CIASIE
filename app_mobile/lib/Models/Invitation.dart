import 'package:reunionou/Models/ActionRecord.dart';
import 'package:reunionou/Models/User.dart';

class Invitation extends ActionRecord {
  String user;
  int status;
  int event;

  Invitation(this.user, this.status, this.event);

  @override
  String toString() {
    return this.user + this.getStatusString();
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

  static Future<List<Invitation>> getByEvent(
      int page, int size, int eventId) async {
    List<Invitation> invitations = [];
    String uri = "/api/invitation/" + eventId.toString();
    dynamic content = await ActionRecord.sendRequest(uri);
    if (eventId != null && content != null && content is List) {
      //print("berfore for");
      for (var y = 0; y < content.length; y++) {
        var i = content[y];
        invitations.add(Invitation(i["user"], i["status"], i["event"]));
        //print("et un event parse");
      }
    } else
      invitations = null;
    return invitations;
  }

  static List<Invitation> mock() {
    return [
      Invitation("e", 1, 1),
    ];
  }

  static List<Invitation> parseTab(dynamic content) {
    List<Invitation> list = [];
    for (var i in content) {
      list.add(Invitation(
        i["user"],
        i["status"],
        i["event"],
      ));
    }
    return list;
  }

  static Future<List<Invitation>> getStatusInvitation(
      int page, int size, int status) async {
    dynamic content = await ActionRecord.sendRequest(
        "/api/invitation/user/" + User.connectedUser.login);
    if (content != null && content is List) {
      List<Invitation> list = [];
      for (var i in Invitation.parseTab(content))
        if (i.status == status) list.add(i);
      return list;
    } else
      return [];
  }

  static Future<Invitation> getUserEventInvitation(
      String userLogin, int eventId) async {
    String uri =
        "/api/invitation?user=" + userLogin + "&event=" + eventId.toString();
    dynamic content = await ActionRecord.sendRequest(uri);
    Invitation invitation;
    if (eventId != null &&
        content != null &&
        content is List &&
        content.isNotEmpty) {
      //print("berfore for");
      invitation = Invitation(
          content[0]["user"], content[0]["status"], content[0]["event"]);
      //print("et un event parse");
    } else
      invitation = null;
    return invitation;
  }

  void setStatus(int newStatus) {
    this.status = newStatus;
    String uri = "/api/updatestatus";
    ActionRecord.sendRequest(uri, method: "POST", object: this);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "user": this.user,
      "status": this.status.toString(),
      "event": this.event.toString()
    };
  }
}
