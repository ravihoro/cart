import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../viewmodel/login_viewmodel.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.deepPurpleAccent,
          body: Center(
            child: Container(
              height: 50,
              width: 200,
              child: SignInButton(
                Buttons.Google,
                onPressed: () async {
                  bool val = await model.login();
                  if (val) {
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    print("Login failed");
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
