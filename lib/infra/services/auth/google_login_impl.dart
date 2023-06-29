import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallet_manager/models/user.dart';


import 'auth_service_helper.dart';

class GoogleLoginServiceImpl implements AuthServiceHelper {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  @override
  Future<User> singIn() async {

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      return User(
          email: googleUser.email,
          photoUrl: googleUser.photoUrl,
          name: googleUser.displayName ?? "");
    } catch (error) {
      throw 'Error on Google Login';
    }
  }

  @override
  Future<void> singOut() async{
    try {
      await googleSignIn.signOut();
    } catch (error) {
      throw 'Error on Google Logout';
    }
  }
}
