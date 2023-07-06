import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/bank_account.dart';
import '../../../domain/models/transaction.dart';

abstract class FinancialDataHelperService {
  late Set<BankAccount> getBankAccounts;

  Future<void> loadData();

  Future<void> getAllAccounts();

  Future<void> updateTransactionsByRange(DateTimeRange dateTimeRange, int page, {int limit = 500});

  Future<List<Transaction>> getTransactions(BalanceType balanceType, {DateTimeRange? range, int page = 1, int limit});

  Future<BankAccount> getAccount(String itemId);

  Future<void> updateAllItem();

  Future<Response> updatingItemById(String itemId);

  Future<String> updateItem(String itemId);
}
