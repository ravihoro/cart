import 'package:cart/view/cart_view.dart';
import 'package:cart/view/home_view.dart';
import 'package:cart/view/item_detail_view.dart';
import 'package:cart/view/login_view.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../view/favorites_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeView(),
        );
        break;
      case '/login_view':
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );
        break;
      case '/item_detail':
        var item = settings.arguments as Item;
        return MaterialPageRoute(
          builder: (_) => ItemDetailView(
            item: item,
          ),
        );
        break;
      case '/cart_view':
        return MaterialPageRoute(
          builder: (_) => CartView(),
        );
        break;
      case '/favorites_view':
        return MaterialPageRoute(
          builder: (_) => FavoritesView(),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
