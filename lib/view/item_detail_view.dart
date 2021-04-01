import 'package:flutter/material.dart';
import '../viewmodel/base_model.dart';
import '../models/item.dart';
import 'package:provider/provider.dart';

class ItemDetailView extends StatelessWidget {
  final Item item;

  ItemDetailView({this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 350),
                  child: IconButton(
                    icon: model.favoritesId.contains(item.id)
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      if (model.favoritesId.contains(item.id)) {
                        model.removeFavorite(item);
                      } else {
                        model.addFavorite(item);
                      }
                    },
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  elevation: 10.0,
                  child: Hero(
                    tag: item.id,
                    child: Container(
                      padding: const EdgeInsets.all(18.0),
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                            item.imageUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Price: \$${item.price}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                SizedBox(height: 15),
                model.cartMap.containsKey(item.id)
                    ? RaisedButton(
                        color: Colors.deepPurpleAccent,
                        child: Text(
                          "Go to Cart",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart_view');
                        },
                      )
                    : RaisedButton(
                        color: Colors.deepPurpleAccent,
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          model.addToCart(item);
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
