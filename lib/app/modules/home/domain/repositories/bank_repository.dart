import '../models/bank_account.dart';

abstract class BankAccountRepository {
  Future<List<BankAccount>> getBankAccountList();

  saveBankAccount(BankAccount bankAccount);

  Future<BankAccount> getBankAccount(String id);

  Future<void> init();
}
