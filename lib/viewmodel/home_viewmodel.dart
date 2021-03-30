import 'package:cart/services/http_service.dart';
import 'base_model.dart';
import '../models/item.dart';
import '../app/locator.dart';
import '../enums/viewstate.dart';

class HomeViewModel extends BaseModel {
  List<Item> _items = [];
  HttpService httpService = locator<HttpService>();

  List<Item> get items => _items;

  loadData() async {
    super.state = ViewState.Loading;
    try {
      List<dynamic> json = await httpService.fetchData();
      print(json);
      if (json != null) {
        _items = json.map((i) => Item.fromJson(i)).toList();
      }
      super.state = ViewState.Idle;
    } catch (e) {
      print(e);
      print("Error fetching data");
      super.state = ViewState.Idle;
    }
  }
}
