import 'package:flutter/foundation.dart';
import '../../../../../shared/navigator/routes.dart';
import '../../repositories/auth_repository.dart';
import '../../states/auth_states.dart';

class AuthViewModel {
  final AuthRepository repository;
  final AuthState state;

  AuthViewModel({
    required this.repository,
    required this.state,
  });

  Future<bool> singIn() async {
    try {
      AuthState.currentUser = await repository.singIn();
      return true;
    } catch (e, _) {
      if (kDebugMode) {
        print(_);
      }
      state.setError(e.toString());
      return false;
    }
  }
}
