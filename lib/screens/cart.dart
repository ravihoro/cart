import 'package:cart/models/my_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/my_model.dart';
import '../models/item.dart';
//import '../screens/favorites_page.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyModel>(
      builder: (context, myModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Cart',
            ),
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.favorite),
            //     onPressed: () {
            //       Navigator.of(context).push(
            //           MaterialPageRoute(builder: (context) => FavoritesPage()));
            //     },
            //   ),
            // ],
          ),
          body: ListView.builder(
            itemCount: myModel.myCart.length,
            itemBuilder: (context, index) {
              return customListTile(myModel.myCart[index], myModel);
            },
          ),
          bottomNavigationBar: BottomAppBar(
            //color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total:  \$${myModel.totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                FlatButton(
                  onPressed: myModel.totalPrice == 0.0 ? () {} : () {},
                  color: myModel.totalPrice == 0.0
                      ? Colors.grey
                      : Colors.deepPurpleAccent,
                  child: Text(
                    "Place Order",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget customListTile(Item item, MyModel myModel) {
    return Card(
      elevation: 10.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    height: 150,
                    width: 125,
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
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      //color: Colors.yellow,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          //Text(item.description),
                          Text(
                            '\$ ${item.price}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Quantity: ",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  myModel.decrementCount(item);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  //color: Colors.red,
                                  height: 30,
                                  width: 30,
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 10.0,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${myModel.cartMap[item.id]}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  myModel.incrementCount(item);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  //color: Colors.red,
                                  height: 30,
                                  width: 30,
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Text(
                    'Remove'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    myModel.removeFromCart(item);
                  },
                ),
                Container(
                  width: 1.0,
                  height: 25.0,
                  color: Colors.grey,
                ),
                InkWell(
                  child: Text(
                    'Move to favorites'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    myModel.moveToFavorites(item);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
