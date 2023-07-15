import 'package:flutter/material.dart';

import '../../infra/services/financial_data_helper/helper.dart';
import '../../infra/services/financial_data_helper/pluggly/pluggly_impl.dart';

class HomeViewModel {
  HomeViewModel({
    required this.openFinanceService,
  });

  final FinancialDataHelperService openFinanceService;
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  DateTimeRange dataRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  loadInitialData() async {
    loading.value = true;
    await openFinanceService.loadData();
    loading.value = false;
  }

  getNewAccount(String itemId) async {
    loading.value = true;
    await openFinanceService.getAccount(itemId);
    loading.value = false;
  }

  void updateAllItem() {
    loading.value = true;
    openFinanceService.updateAllItem();
    loading.value = false;
  }

  void updateTransactionsByRange(DateTimeRange date) {
    loading.value = true;
    openFinanceService.updateTransactionsByRange(date, 1);
    loading.value = false;
  }
}
