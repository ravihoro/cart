import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 50,
          width: 200,
          child: SignInButton(
            Buttons.Google,
            onPressed: () {
              print("Sign in");
            },
          ),
        ),
      ),
    );
  }
}
