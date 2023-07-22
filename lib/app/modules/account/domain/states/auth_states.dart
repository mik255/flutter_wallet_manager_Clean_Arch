import '../../../../shared/models/user.dart';

abstract class AuthState {
  static User currentUser = User(
    name: '',
    email: '',
    password: '',
  );

  setError(String error);

  String getErrorValue();

  get errorListener;
}
