import '../../models/user.dart';

abstract class AuthServiceHelper {
  Future<User>  auth();
}
