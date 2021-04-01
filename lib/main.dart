import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_core/firebase_core.dart';
import './viewmodel/theme_model.dart';
import './app/locator.dart';
import './app/router.dart' as router;
import './viewmodel/base_model.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("isLoggedIn") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
      builder: (context, baseModel, child) {
        return ViewModelBuilder<ThemeModel>.reactive(
          viewModelBuilder: () => ThemeModel(),
          builder: (context, model, child) {
            return MaterialApp(
              themeMode: model.currentTheme() ?? ThemeMode.light,
              theme: ThemeData(
                bottomAppBarColor: Colors.grey[300],
                primaryColor: Colors.deepPurpleAccent,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.deepPurpleAccent,
                bottomAppBarColor: Colors.black38,
              ),
              title: 'Cart',
              debugShowCheckedModeBanner: false,
              initialRoute: '/login_view',
              onGenerateRoute: router.Router.generateRoute,
            );
          },
        );
      },
      viewModelBuilder: () => locator<BaseModel>(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   Future<bool> isLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool("isLoggedIn") ?? false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<MyModel>(
//           create: (context) => MyModel(),
//         ),
//         ChangeNotifierProvider<ThemeModel>(
//           create: (context) => ThemeModel(),
//         ),
//       ],
//       //create: (context) => MyModel(),
//       child: Consumer<ThemeModel>(
//         builder: (context, themeModel, child) {
//           return MaterialApp(
//             theme: ThemeData(
//               bottomAppBarColor: Colors.grey[300],
//               primaryColor: Colors.deepPurpleAccent,
//             ),
//             darkTheme: ThemeData(
//               brightness: Brightness.dark,
//               primaryColor: Colors.deepPurpleAccent,
//               bottomAppBarColor: Colors.black38,
//             ),
//             themeMode: themeModel.currentTheme(),
//             title: 'Cart',
//             debugShowCheckedModeBanner: false,
//             home: FutureBuilder(
//               future: isLoggedIn(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 return snapshot.data ? HomePage() : LoginPage();
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
