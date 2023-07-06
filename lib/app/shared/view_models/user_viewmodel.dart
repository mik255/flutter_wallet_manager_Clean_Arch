import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../../domain/models/user.dart';
import '../../../infra/abstract_preferences_helper.dart';
import '../../../infra/services/auth/auth_service_helper.dart';


class UserViewModel {
  User? user;
  IPreferencesHelper helper;
  ValueNotifier<String> message = ValueNotifier('');

  UserViewModel({
    required this.helper,
  });

  Future<bool> login(AuthServiceHelper authServiceHelper) async {
    try {
      user = await authServiceHelper.singIn();
      await helper.saveData('user', jsonEncode(user!.toMap()));
      return true;
    } catch (e) {
      message.value = e.toString();
      return false;
    }
  }
  Future<void> singOut(AuthServiceHelper authServiceHelper) async {
    try {
      await authServiceHelper.singOut();
      await helper.deleteData('user');
    } catch (e) {
      message.value = e.toString();
    }
  }
}
