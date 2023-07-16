import '../../repositories/auth_repository.dart';
import '../instances.dart';

abstract class Credentials {}

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase({required this.repository});

  Future<void> call() async {
    currentUser = await repository.singIn();
  }
}
