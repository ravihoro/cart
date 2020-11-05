import 'package:flutter/material.dart';
import 'item.dart';

class MyModel extends ChangeNotifier {
  List<Item> _favorites = List<Item>();
  List<Item> _myCart = List<Item>();

  List<Item> get favorites => _favorites;
  List<Item> get myCart => _myCart;

  List<int> _favoritesId = new List<int>();

  List<int> get favoritesId => _favoritesId;

  void addFavorite(Item item) {
    _favorites.add(item);
    _favoritesId.add(item.id);
    notifyListeners();
  }

  void removeFavorite(Item item) {
    _favorites.remove(item);
    _favoritesId.remove(item.id);
    notifyListeners();
  }
}
