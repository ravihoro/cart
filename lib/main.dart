import 'package:cart/models/my_model.dart';
import 'package:cart/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './models/my_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
        ),
        title: 'Cart',
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: isLoggedIn(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data ? HomePage() : LoginPage();
          },
        ),
      ),
    );
  }
}
