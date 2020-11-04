import 'package:cart/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  @override
  initState() {
    super.initState();
    getUser();
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
      body: Center(
        child: RaisedButton(child: Text("Sign Out"), onPressed: () {}),
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
