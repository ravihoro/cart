import 'package:cart/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/network.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  Future data;
  Network network;

  @override
  initState() {
    super.initState();
    getUser();
    data = fetchData();
  }

  fetchData() async {
    network = Network(url: "https://fakestoreapi.com/products/1");
    return await network.fetchData();
  }

  getUser() {
    user = _auth.currentUser;
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
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //print(data);
            return Text("${snapshot.data['title']}");
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
}
