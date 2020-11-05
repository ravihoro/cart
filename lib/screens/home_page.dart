import 'package:cart/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/network.dart';
import '../models/item.dart';
import 'package:provider/provider.dart';
import '../models/my_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  Future data;
  ItemList itemList;

  @override
  initState() {
    super.initState();
    user = _auth.currentUser;
    data = fetchData();
  }

  Future fetchData() async {
    return await Network(url: "https://fakestoreapi.com/products").fetchData();
  }

  signOut() async {
    await GoogleSignIn().signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
        ),
      ),
      body: FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot snapshot) {
          // print(data);
          // print(snapshot.data == null);
          if (snapshot.hasData) {
            itemList = ItemList.fromJson(snapshot.data);
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: itemList.items.length,
              itemBuilder: (context, index) {
                return customCard(itemList.items[index]);
              },
            );
            //return Text("fetched");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      drawer: customDrawer(),
    );
  }

  Widget customDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(user.email),
            accountName: Text(
              user.displayName,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL),
            ),
          ),
          ListTile(
            //leading: Icon(Icons.exit_to_app),
            title: Text("Sign Out",
                style: TextStyle(color: Colors.deepPurpleAccent)),
            trailing: Icon(
              Icons.exit_to_app,
              color: Colors.deepPurpleAccent,
            ),
            onTap: () async {
              await signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }

  Widget customCard(Item item) {
    //int id = itemList.items.indexOf(item);
    return Consumer<MyModel>(
      builder: (context, myModel, child) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              //margin: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.deepPurpleAccent),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.2),
                //     spreadRadius: 3.0,
                //     blurRadius: 5.0,
                //   ),
                // ]
              ),
              //height: 350,
              //width: 100,
              //elevation: 10.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0, top: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            //itemList.items[id].isFavorite
                            myModel.favoritesId.contains(item.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.deepPurpleAccent,
                          ),
                          onPressed: () {
                            if (myModel.favoritesId.contains(item.id)) {
                              myModel.removeFavorite(item);
                            } else {
                              myModel.addFavorite(item);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          item.imageUrl,
                        ),
                      ),
                    ),
                  ),
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
                  Text(
                    '\$${item.price.toString()}',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.amber,
                          ),
                          Text("Add to Cart",
                              style: TextStyle(color: Colors.amber)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
