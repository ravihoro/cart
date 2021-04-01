import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  signOut() async {
    await GoogleSignIn().signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    //Trigger the authentication flow
    final GoogleSignInAccount user = await GoogleSignIn().signIn();

    //Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await user.authentication;

    //Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //Once signed in, return the credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
