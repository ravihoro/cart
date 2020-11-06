//import 'package:cart/screens/cart.dart';
import 'package:cart/screens/favorites_page.dart';
import 'package:cart/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/network.dart';
import '../models/item.dart';
import 'package:provider/provider.dart';
import '../models/my_model.dart';
import '../util/widgets.dart';
import 'item_detail_page.dart';

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
          'Items',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoritesPage()));
            },
          ),
          CustomCartIcon(),
        ],
      ),
      body: FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot snapshot) {
          // print(data);
          // print(snapshot.data == null);
          if (snapshot.hasData) {
            itemList = ItemList.fromJson(snapshot.data);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.5,
              ),
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
    return Consumer<MyModel>(
      builder: (context, myModel, child) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ItemDetailPage(item: item)));
          },
          child: Padding(
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
                        customSizedBox(30),
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
                        customSizedBox(5.0),
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
                        customSizedBox(5.0),
                        Text(
                          '\$ ${item.price.toString()}',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        customSizedBox(5.0),
                      ],
                    ),
                    Positioned(
                      right: 1.0,
                      top: 1.0,
                      child: IconButton(
                        icon: Icon(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
