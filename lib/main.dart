import 'package:cart/models/my_model.dart';
import 'package:cart/screens/login_page.dart';
import 'package:cart/view/home_view.dart';
import 'package:cart/view/theme_switch.dart';
import 'package:cart/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import './screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './models/my_model.dart';
import './viewmodel/theme_model.dart';
import './app/locator.dart';
import './app/router.dart' as router;
import './viewmodel/base_model.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseModel>(
          create: (context) => locator<BaseModel>(),
        ),
      ],
      child: ViewModelBuilder<ThemeModel>.reactive(
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
            initialRoute: '/home_view',
            onGenerateRoute: router.Router.generateRoute,
          );
        },
      ),
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
