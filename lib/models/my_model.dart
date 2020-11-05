import 'package:flutter/material.dart';
import 'item.dart';

class MyModel extends ChangeNotifier {
  ItemList _favorites;
  ItemList _myCart;

  ItemList get favorites => _favorites;
  ItemList get myCart => _myCart;

  void addFavorite(Item item) {
    _favorites.items.remove(item);
    notifyListeners();
  }

  void removeFavorite(Item item) {
    _favorites.items.remove(item);
    notifyListeners();
  }
}
