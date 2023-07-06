import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'infra/services/financial_data_helper/helper.dart';
import 'infra/services/financial_data_helper/pluggly/pluggly_impl.dart';


class MainStances {
  static FinancialDataHelperService openFinanceService = PlugglyService();
  static ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  static init() async {
    loading.value = true;
    preferences = await SharedPreferences.getInstance();
    loading.value = false;
  }

  static late SharedPreferences preferences;
}
