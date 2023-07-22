import 'dart:convert';
import '../../domain/models/bank_account.dart';
import '../../domain/repositories/bank_repository.dart';
import '../datasources/bank_datasource.dart';

class BankAccountRepositoryImpl implements BankAccountRepository {
  final BankAccountDataSource bankAccountDataSource;

  BankAccountRepositoryImpl({
    required this.bankAccountDataSource,
  });

  @override
  saveBankAccount(BankAccount bankAccount) async {
    await bankAccountDataSource.saveBankAccount(bankAccount);
  }

  @override
  Future<void> init() async {
    await bankAccountDataSource.init();
  }

  @override
  Future<BankAccount> getBankAccount(String id) async {
    return await bankAccountDataSource.getBankAccount(id);
  }

  @override
  Future<List<BankAccount>> getBankAccountList() async {
    return await bankAccountDataSource.getBankAccountList();
  }
}
