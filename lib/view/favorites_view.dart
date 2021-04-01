import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../util/widgets.dart';
import '../models/item.dart';
import '../viewmodel/base_model.dart';

class FavoritesView extends StatelessWidget {
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
      body: FavoritesGrid(),
    );
  }
}

class FavoritesGrid extends ViewModelWidget<BaseModel> {
  @override
  Widget build(BuildContext context, BaseModel model) {
    return model.favoritesId.length == 0
        ? Center(
            child: Text(
              'No favorites.',
            ),
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
            ),
            itemCount: model.favoritesId.length,
            itemBuilder: (context, index) {
              return customCard(model.favorites[index], model, context);
            },
          );
  }

  Widget customCard(Item item, BaseModel myModel, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/item_detail', arguments: item);
      },
      child: Container(
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
                SizedBox(height: 35),
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
                SizedBox(height: 5),
                Text(
                  '${item.title}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '\$ ${item.price}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  height: 1.0,
                  thickness: 1.0,
                ),
                SizedBox(height: 5),
                FlatButton(
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    myModel.addToCart(item);
                    myModel.removeFavorite(item);
                  },
                  child: Text('Move to Cart',
                      style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 5),
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
      ),
    );
  }
}
