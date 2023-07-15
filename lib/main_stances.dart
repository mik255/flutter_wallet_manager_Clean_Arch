import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'infra/services/financial_data_helper/helper.dart';
import 'infra/services/financial_data_helper/pluggly/pluggly_impl.dart';


class MainStances {

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static late SharedPreferences preferences;
}
