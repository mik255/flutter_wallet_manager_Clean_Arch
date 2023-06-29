import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallet_manager/models/user.dart';
import 'package:wallet_manager/services/auth/auth_service_helper.dart';

class GoogleLoginServiceImpl implements AuthServiceHelper {
  @override
  Future<User> auth() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
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
}
