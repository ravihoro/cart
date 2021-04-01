import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStatusViewModel extends FutureViewModel<bool> {
  Future<bool> isLoggedIn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("isLoggedIn") ?? false;
  }

  @override
  Future<bool> futureToRun() => isLoggedIn();
}
