import 'package:flutter/material.dart';
import 'item.dart';

class MyModel extends ChangeNotifier {
  List<Item> _favorites = List<Item>();
  List<Item> _myCart = List<Item>();

  List<Item> get favorites => _favorites;
  List<Item> get myCart => _myCart;

  int _itemsInCart = 0;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  int get itemsInCart => _itemsInCart;

  List<int> _favoritesId = new List<int>();
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

  void moveToFavorites(Item item) {
    removeFromCart(item);
    addFavorite(item);
  }

  void removeFavorite(Item item) {
    _favorites.remove(item);
    _favoritesId.remove(item.id);
    notifyListeners();
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

  void addToCart(Item item) {
    _cartMap.addAll({item.id: 1});
    _myCart.add(item);
    _totalPrice += item.price;
    _itemsInCart++;
    notifyListeners();
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
