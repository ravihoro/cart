import 'package:http/http.dart';
import 'dart:convert';

class Network {
  final String url;
  Network({this.url});

  Future fetchData() async {
    Response response = await get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
