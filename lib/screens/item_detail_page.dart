import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/my_model.dart';
import '../models/item.dart';
import 'cart.dart';

class ItemDetailPage extends StatefulWidget {
  final Item item;
  //final int id;

  ItemDetailPage({this.item});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<MyModel>(
      builder: (context, myModel, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 350),
                child: IconButton(
                  icon: myModel.favoritesId.contains(widget.item.id)
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    if (myModel.favoritesId.contains(widget.item.id)) {
                      myModel.removeFavorite(widget.item);
                    } else {
                      myModel.addFavorite(widget.item);
                    }
                  },
                ),
              ),
              customSizedBox(5),
              Card(
                elevation: 10.0,
                child: Hero(
                  tag: widget.item.id,
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      //color: Colors.red,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          widget.item.imageUrl,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              customSizedBox(15),
              Text(
                widget.item.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              customSizedBox(15),
              Text(
                widget.item.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
              customSizedBox(15),
              Text(
                'Price: \$${widget.item.price}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              customSizedBox(15),
              myModel.cartMap.containsKey(widget.item.id)
                  ? RaisedButton(
                      color: Colors.deepPurpleAccent,
                      child: Text(
                        "Go to Cart",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        //myModel.addToCart(widget.item);
                        //myModel.removeFromCart(widget.item);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Cart()));
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
                        myModel.addToCart(widget.item);
                      },
                    ),
            ],
          ),
        );
      },
    ));
  }

  Widget customSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
