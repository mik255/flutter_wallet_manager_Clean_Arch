import '../../../../shared/models/user.dart';

abstract class AuthRepository {
  Future<User> singIn();

  Future<void> singOut();
}
