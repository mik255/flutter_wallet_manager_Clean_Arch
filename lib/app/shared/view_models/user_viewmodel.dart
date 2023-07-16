import 'package:flutter/cupertino.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/instances.dart';

class AuthViewModel {
  ValueNotifier<String> message = ValueNotifier('');
  AuthRepository authRepository;

  AuthViewModel({
    required this.authRepository,
  });

  Future<bool> singIn() async {
    try {
      await authRepository.singIn();
      return true;
    } catch (e) {
      message.value = e.toString();
      return false;
    }
  }

  Future<void> singOut() async {
    try {
      await authRepository.singOut();
    } catch (e) {
      message.value = e.toString();
    }
  }
  User getUser(){
    return currentUser;
  }
}
