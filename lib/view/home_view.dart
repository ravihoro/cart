import 'package:flutter/material.dart';
import '../viewmodel/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../models/item.dart';
import '../enums/viewstate.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.loadData(),
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: model.state == ViewState.Loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.5,
                  ),
                  itemCount: model.items.length,
                  itemBuilder: (context, index) {
                    return customCard(model.items[index]);
                  },
                ),
        );
      },
    );
  }

  Widget customCard(Item item) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        elevation: 10.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Expanded(
                    child: Hero(
                      tag: item.id,
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
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "${item.title}",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    '\$ ${item.price.toString()}',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
              // Positioned(
              //   right: 1.0,
              //   top: 1.0,
              //   child: IconButton(
              //     icon: Icon(
              //       myModel.favoritesId.contains(item.id)
              //           ? Icons.favorite
              //           : Icons.favorite_border,
              //       color: Colors.deepPurpleAccent,
              //     ),
              //     onPressed: () {
              //       if (myModel.favoritesId.contains(item.id)) {
              //         myModel.removeFavorite(item);
              //       } else {
              //         myModel.addFavorite(item);
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
