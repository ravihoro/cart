import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  final String url = "https://fakestoreapi.com/products";

  Future fetchData() async {
    http.Response response;
    try {
      response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Error fetching data");
        return null;
      }
    } catch (e) {
      print("Error");
      return null;
    }
  }
}
