import 'package:reunionou/Models/ActionRecord.dart';

class Comment extends ActionRecord {
  String content, owner;
  int event, id;
  DateTime date;

  Comment(this.id, this.owner, this.event, this.content, this.date);

  @override
  Map<String, dynamic> toJson() {
    return {"content": this.content, "owner": this.owner, "event": this.event};
  }

  static Future<List<Comment>> getByEvent(int id) async {
    dynamic content =
        await ActionRecord.sendRequest("/api/comment/event/" + id.toString());
    if (content != null && content is List)
      content = Comment.parseTab(content);
    else
      return [];
    return content;
  }

  static List<Comment> parseTab(content) {
    List<Comment> comments = [];
    for (dynamic i in content) {
      comments.add(Comment(i["id"], i["owner"], i["event"], i["content"],
          DateTime.parse(i["date"])));
    }
    return comments;
  }

  String formatDateTime() {
    if (this.date == null) return "";
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

  static Future<dynamic> create(String user, int event, String content) async {
    Comment comment = Comment(-1, user, event, content, null);
    return await ActionRecord.sendRequest("/api/addComment",
        method: "POST", object: comment);
  }
}
