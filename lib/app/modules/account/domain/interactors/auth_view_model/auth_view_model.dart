import 'package:flutter/foundation.dart';
import '../../../../../shared/navigator/routes.dart';
import '../../repositories/auth_repository.dart';
import '../../states/auth_states.dart';

class AuthViewModel {
  final AuthRepository repository;
  final AuthState state;
  final Routes routes;

  AuthViewModel({
    required this.repository,
    required this.state,
    required this.routes,
  });

  Future<void> singIn() async {
    try {
      AuthState.currentUser = await repository.singIn();
      routes.navigateTo('home');
    } catch (e, _) {
      if (kDebugMode) {
        print(_);
      }
      state.setError(e.toString());
    }
  }
}
