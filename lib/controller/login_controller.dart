import 'package:flutter/cupertino.dart';
import '../domain/models/user.dart';
import '../infra/abstract_preferences_helper.dart';


class LoginController {
  User user;
  IPreferencesHelper helper;
  ValueNotifier<String> message = ValueNotifier('');
  var formKey = GlobalKey<FormState>();

  LoginController({
    required this.user,
    required this.helper,
  });

  login() async {

  }

}
