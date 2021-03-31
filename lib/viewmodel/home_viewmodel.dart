import 'package:cart/services/http_service.dart';
import '../models/item.dart';
import '../app/locator.dart';
import '../enums/viewstate.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<Item> _items = [];
  HttpService httpService = locator<HttpService>();

  List<Item> get items => _items;

  ViewState _state = ViewState.Idle;

  get state => _state;

  set state(ViewState state) {
    _state = state;
    notifyListeners();
  }

  loadData() async {
    state = ViewState.Loading;
    try {
      List<dynamic> json = await httpService.fetchData();
      print(json);
      if (json != null) {
        _items = json.map((i) => Item.fromJson(i)).toList();
      }
      state = ViewState.Idle;
    } catch (e) {
      print(e);
      print("Error fetching data");
      state = ViewState.Idle;
    }
  }
}
