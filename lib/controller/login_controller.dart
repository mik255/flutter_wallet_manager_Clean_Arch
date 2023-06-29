import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../data/abstract_preferences_helper.dart';
import '../models/user.dart';

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
