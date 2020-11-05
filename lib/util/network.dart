import 'package:cart/models/item.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Network {
  final String url;
  Network({this.url});

  Future<ItemList> loadItems() async {
    final Response response = await get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      print(response.body);
      return ItemList.fromJson(json.decode(response.body));
    } else
      throw Exception("Failed to get Items");
  }

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
