import 'package:wallet_manager/app/modules/home/domain/models/transaction.dart';

import '../models/bank_account.dart';

abstract class BankAccountRepository {
  saveBankAccount(BankAccount bankAccount);
  Future<List<BankAccount>>  getBankAccounts();
}
