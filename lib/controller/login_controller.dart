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
    message.value = '';
    String? result = await helper.getData('users');
    if (result != null) {
      List<User> users = _fromStringList(result);
      for (int i = 0; i < users.length; i++) {
        if (users[i].email == user.email &&
            users[i].password == user.password) {
          return true;
        }
      }
    }
    message.value = 'Email or password is not correct';
  }

  List<User> _fromStringList(String list) {
    List<dynamic> resultList = jsonDecode(list);
    List<User> users = [];
    for (Map<String, dynamic> json in resultList) {
      users.add(User.fromMap(json));
    }
    return users;
  }
}
