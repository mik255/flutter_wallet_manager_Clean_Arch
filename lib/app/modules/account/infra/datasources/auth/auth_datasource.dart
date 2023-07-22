import '../../../../../shared/models/user.dart';

abstract class AuthDataSource {
  Future<User> singIn();

  Future<void> singOut();
}
