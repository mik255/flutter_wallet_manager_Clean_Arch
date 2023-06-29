import '../../../domain/models/user.dart';


abstract class AuthServiceHelper {
  Future<User>  singIn();
  Future<void>  singOut();
}
