import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../shared/models/user.dart';
import 'auth_datasource.dart';

class GoogleLoginServiceImpl extends AuthDataSource{
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
