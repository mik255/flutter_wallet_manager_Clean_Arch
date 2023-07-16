import '../usecases/auth/auth_usecase.dart';
import '../models/user.dart';

abstract class AuthRepository {
  Future<User> singIn();
  Future<void> singOut();
}
