import 'package:flutter/cupertino.dart';
import '../domain/states/auth_states.dart';

class AuthStateImpl implements AuthState {
  final ValueNotifier<String> _error = ValueNotifier('');

  @override
  setError(String error) {
    _error.value = error;
  }

  @override
  String getErrorValue() {
    return _error.value;
  }

  @override
  ValueNotifier<String> get errorListener => _error;
}
