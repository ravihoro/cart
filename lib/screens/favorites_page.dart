import 'package:flutter/material.dart';
import '../models/my_model.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../util/widgets.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites',
        ),
        actions: [
          CustomCartIcon(),
        ],
      ),
      body: Consumer<MyModel>(
        builder: (context, myModel, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
            ),
            itemCount: myModel.favoritesId.length,
            itemBuilder: (context, index) {
              return customCard(myModel.favorites[index], myModel);
            },
          );
        },
      ),
    );
  }

  Widget customCard(Item item, MyModel myModel) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customSizedBox(35),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                        item.imageUrl,
                      ),
                    ),
                  ),
                ),
              ),
              customSizedBox(5),
              Text(
                '${item.title}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              customSizedBox(5),
              Text(
                '\$ ${item.price}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              customSizedBox(5),
              Divider(
                height: 1.0,
                thickness: 1.0,
              ),
              customSizedBox(5),
              FlatButton(
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  myModel.addToCart(item);
                  myModel.removeFavorite(item);
                },
                child:
                    Text('Move to Cart', style: TextStyle(color: Colors.white)),
              ),
              customSizedBox(5),
            ],
          ),
          Positioned(
            right: 1.0,
            top: 1.0,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.deepPurpleAccent,
              ),
              onPressed: () {
                myModel.removeFavorite(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget customSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
