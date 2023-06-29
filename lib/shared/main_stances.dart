import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/financial_data_helper/pluggly/pluggly_impl.dart';

class MainStances {
  static PlugglyService plugglyService = PlugglyService();
  static ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  static init() async {
    loading.value = true;
    preferences = await SharedPreferences.getInstance();
    await plugglyService.loadData();
    loading.value = false;
  }

  getBankAccounts(String id) async {
    loading.value = true;
     plugglyService.getAccount(id);
    loading.value = false;
  }

  static late SharedPreferences preferences;
}
