import 'package:flutter/material.dart';
import 'package:wallet_manager/domain/models/bank_account.dart';
import '../../../domain/repositories/bank_repository.dart';

class HomeViewModel {
  HomeViewModel({
    required this.bankAccountRepository,
  });

  final BankAccountRepository bankAccountRepository;
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  DateTimeRange dataRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  loadInitialData() async {
    loading.value = true;
    await bankAccountRepository.getBankAccounts();
    loading.value = false;
  }


}
