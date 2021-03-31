import 'package:flutter/material.dart';
import '../models/item.dart';
//import '../enums/viewstate.dart';

class BaseModel extends ChangeNotifier {
  List<Item> _favorites = [];
  List<Item> _myCart = [];

  // ViewState _state = ViewState.Loading;

  // ViewState get state => _state;

  // set state(ViewState state) {
  //   _state = state;
  //   notifyListeners();
  // }

  List<Item> get favorites => _favorites;
  List<Item> get myCart => _myCart;

  int _itemsInCart = 0;
  int get itemsInCart => _itemsInCart;

  List<int> _favoritesId = [];
  Map<int, int> _cartMap = new Map<int, int>();

  List<int> get favoritesId => _favoritesId;
  Map<int, int> get cartMap => _cartMap;

  double _totalPrice = 0;

  get totalPrice => _totalPrice;

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
    _totalPrice += item.price;
    _itemsInCart++;
    notifyListeners();
  }

  void moveToFavorites(Item item) {
    removeFromCart(item);
    addFavorite(item);
  }

  void incrementCount(Item item) {
    _cartMap.update(item.id, (value) => _cartMap[item.id] + 1);
    _totalPrice += item.price;
    _itemsInCart++;
    notifyListeners();
  }

  void decrementCount(Item item) {
    int count = _cartMap[item.id];
    if (count == 1) {
      removeFromCart(item);
    } else {
      _itemsInCart--;
      _cartMap.update(item.id, (value) => count - 1);
      _totalPrice -= item.price;
      notifyListeners();
    }
  }

  void removeFromCart(Item item) {
    int count = _cartMap[item.id];
    _cartMap.remove(item.id);
    _myCart.remove(item);
    _totalPrice = _totalPrice - (count * item.price);
    _itemsInCart -= count;
    notifyListeners();
  }
}
