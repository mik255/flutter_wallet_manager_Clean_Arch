

import 'package:flutter/cupertino.dart';

import '../../infra/services/financial_data_helper/helper.dart';
import '../../infra/services/financial_data_helper/pluggly/pluggly_impl.dart';

class HomeViewModel{
  FinancialDataHelperService openFinanceService = PlugglyService();
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  loadInitialData() async {
    loading.value = true;
    await openFinanceService.loadData();
    loading.value = false;
  }
}