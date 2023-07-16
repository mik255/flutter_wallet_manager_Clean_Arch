import '../models/bank_account.dart';

abstract class BankAccountRepository {
  saveBankAccount(BankAccount bankAccount);
  Future<List<BankAccount>>  getBankAccounts();
}
