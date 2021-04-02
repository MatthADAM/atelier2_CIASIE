import 'dart:convert';
import 'dart:io';

abstract class ActionRecord {
  static const String API_URL = "https://docketu.iutnc.univ-lorraine.fr:11501";

  static Future<dynamic> sendRequest(String uri,
      {String method = "GET", ActionRecord object}) async {
    dynamic res;
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    try {
      HttpClientRequest request;
      switch (method) {
        case "POST":
          request = await client.postUrl(Uri.parse(API_URL + uri));
          request.persistentConnection = true;
          request.headers.persistentConnection = true;
          request.headers.set('content-type', 'application/json');
          if (object != null) {
            var encoded = json.encode(object.toJson());
            //print(encoded);
            request.write(encoded);
          }
          break;
        default:
          request = await client.getUrl(Uri.parse(API_URL + uri));
          request.persistentConnection = true;
          request.headers.persistentConnection = true;
          request.headers.contentType = ContentType.json;
          break;
      }

      print("request to: " + API_URL + uri);

      //print("int request");
      HttpClientResponse response = await request.close();
      if (response.statusCode >= 200 || response.statusCode < 300) {
        res = jsonDecode(await response.transform(utf8.decoder).join());
      }
    } catch (error) {
      print(error);
      return null;
    }
    return res;
  }

  Map<String, dynamic> toJson();
}
