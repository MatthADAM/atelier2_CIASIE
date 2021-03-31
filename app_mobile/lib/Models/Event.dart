import 'package:reunionou/Models/ActionRecord.dart';
import 'package:reunionou/Models/Invitation.dart';

class Event extends ActionRecord {
  String adress, owner, name, token;
  int id, postCode;
  bool public;
  DateTime date;

  Event(this.id, this.adress, this.owner, this.postCode, this.public, this.date,
      this.name,
      {this.token});

  static Future<Event> getById(int id) async {
    Event event;
    if (id != null) {
      dynamic content =
          await ActionRecord.sendRequest("/api/event/" + id.toString());
      if (content != null && content is List && content[0] != null) {
        event = Event(
            content[0]["id"],
            content[0]["adress"],
            content[0]["owner"],
            content[0]["postCode"],
            (content[0]["public"] == 1) ? true : false,
            content[0]["date"] != null
                ? DateTime.parse(content[0]["date"])
                : null,
            content[0]["name"],
            token: content[0]["token"]);
      }
    }
    return event;
  }

  static List<Event> parseTab(dynamic content) {
    List<Event> list = [];
    for (var y = 0; y < content.length; y++) {
      var i = content[y];
      list.add(Event(
          i["id"],
          i["adress"],
          i["owner"],
          i["postCode"],
          (i["public"] == 1) ? true : false,
          i["date"] != null ? DateTime.parse(i["date"]) : null,
          i["name"],
          token: i["token"]));
    }
    return list;
  }

  static Future<List<Event>> getUserEvents(
      String userId, int page, int size) async {
    if (userId != null) {
      dynamic content =
          await ActionRecord.sendRequest("/api/event/owner/" + userId);
      if (content != null && content is List) {
        return Event.parseTab(content);
      }
    }
    return [];
  }

  static Future<List<Event>> getPublicEvents(int page, int size) async {
    dynamic content = await ActionRecord.sendRequest("/api/event?public=1");
    if (content != null && content is List) {
      return Event.parseTab(content);
    } else
      return [];
  }

  static List<Event> mock() {
    return [
      Event(1, "this is an adress", "Toto", 54000, true,
          DateTime.parse("2021-25-06 12:30:00"), "My First Event"),
      Event(1, "this is a second adress", "Tata", 55500, true, DateTime.now(),
          "My Second Event"),
    ];
  }

  String formatDateTime() {
    if (this.date == null) return "no date planned";
    return this.date.hour.toString() +
        ":" +
        this.date.minute.toString() +
        "\t" +
        this.date.day.toString() +
        "/" +
        this.date.month.toString() +
        "/" +
        this.date.year.toString();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "owner": this.owner,
      "name": this.name,
      "adress": this.adress,
      "postCode": this.postCode,
      "public": this.public ? 1 : 0,
      "date": this.date.toIso8601String()
    };
  }

  static Future<List<Event>> getStatusEvents(
      int page, int size, int status) async {
    List<Invitation> invitations =
        await Invitation.getStatusInvitation(page, size, status);
    if (invitations != null && invitations is List) {
      return await Event.getByIds(invitations.map((e) {
        return e.event;
      }).toList());
    } else
      return [];
  }

  static Future<List<Event>> getByIds(List<int> eventIds) async {
    List<Event> events = [];
    for (var eventId in eventIds) {
      events.add(await Event.getById(eventId));
    }
    return events;
  }

  static Future<dynamic> create(String adress, String connectedUser,
      int postCode, bool public, DateTime date, String name) async {
    Event event =
        Event(-1, adress, connectedUser, postCode, public, date, name);
    return await ActionRecord.sendRequest("/api/addEvent",
        method: "POST", object: event);
  }

  Future<bool> delete() async {
    dynamic content = await ActionRecord.sendRequest(
        "/api/delete/event/" + this.id.toString(),
        method: "POST");
    return content != null;
  }
/*
  static Future<Event> update(String adress, int postCode, bool bool,
      DateTime selectedDate, String name) async {
    Event event =
        Event(-1, adress, connectedUser, postCode, public, date, name);
    return await ActionRecord.sendRequest("/api/addEvent",
        method: "POST", object: this);
  }
  */
}
