import 'package:reunionou/Models/ActionRecord.dart';

class Event extends ActionRecord {
  String adress, owner, name;
  int id, postCode;
  bool public;
  DateTime date;

  Event(int id, String adress, String owner, int postcode, bool public,
      DateTime date, String name) {
    this.adress = adress;
    this.owner = owner;
    this.postCode = postcode;
    this.public = public;
    this.date = date;
    this.name = name;
  }

  static Event getById(int id) {
    Event event = Event(1, "this is an adress", "Toto", 54000, true,
        DateTime.now(), "My First Event");
    return event;
  }

  static List<Event> getSize(int page, int size) {
    return [
      Event(1, "this is an adress", "Toto", 54000, true, DateTime.now(),
          "My First Event"),
      Event(1, "this is a second adress", "Tata", 55500, true, DateTime.now(),
          "My Second Event"),
    ];
  }
}
