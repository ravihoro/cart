import 'package:stacked/stacked.dart';
import '../services/authentication.dart';
import '../app/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel {
  Authentication authentication = locator<Authentication>();

  Future<bool> login() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await authentication.signInWithGoogle();
    _prefs.setBool('isLoggedIn', true);
    return true;
  }

  Future<bool> logout() async {
    await authentication.signOut();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('isLoggedIn', false);
    return true;
  }
}
