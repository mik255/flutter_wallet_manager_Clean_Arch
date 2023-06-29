import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../../data/abstract_preferences_helper.dart';
import '../../../models/user.dart';
import '../../../services/auth/auth_service_helper.dart';

class LoginViewModel {
  User? user;
  IPreferencesHelper helper;
  ValueNotifier<String> message = ValueNotifier('');
  var formKey = GlobalKey<FormState>();

  LoginViewModel({
    required this.helper,
  });

  Future<bool> login(AuthServiceHelper authServiceHelper) async {
    try {
      user = await authServiceHelper.auth();
      await helper.saveData('user', jsonEncode(user!.toMap()));
      return true;
    } catch (e) {
      message.value = e.toString();
      return false;
    }
  }
}
