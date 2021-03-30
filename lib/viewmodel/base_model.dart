import 'package:stacked/stacked.dart';
import '../models/item.dart';
import '../enums/viewstate.dart';

class BaseModel extends BaseViewModel {
  List<Item> _favorites = [];
  List<Item> _myCart = [];

  ViewState _state = ViewState.Loading;

  ViewState get state => _state;

  set state(ViewState state) {
    _state = state;
    notifyListeners();
  }

  List<Item> get favorites => _favorites;
  List<Item> get myCart => _myCart;

  int _itemsInCart = 0;
  int get itemsInCart => _itemsInCart;

  List<int> _favoritesId = [];
  Map<int, int> _cartMap = new Map<int, int>();

  List<int> get favoritesId => _favoritesId;
  Map<int, int> get cartMap => _cartMap;

  void addFavorite(Item item) {
    if (!favoritesId.contains(item.id)) {
      _favorites.add(item);
      _favoritesId.add(item.id);
      notifyListeners();
    }
  }

  void removeFavorite(Item item) {
    _favorites.remove(item);
    _favoritesId.remove(item.id);
    notifyListeners();
  }

  void addToCart(Item item) {
    _cartMap.addAll({item.id: 1});
    _myCart.add(item);
    //_totalPrice += item.price;
    _itemsInCart++;
    notifyListeners();
  }
}
