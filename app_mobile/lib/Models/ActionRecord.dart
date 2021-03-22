import 'package:http/http.dart' as http;

abstract class ActionRecord {
  static const String API_URL = "http://test";

  Object sendRequest(String uri) async {
    var object;
    object = await http.get(Uri.https(API_URL, uri));
    return object;
  }
}
