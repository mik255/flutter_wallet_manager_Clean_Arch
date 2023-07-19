import 'dart:convert';
import '../../domain/models/bank_account.dart';
import '../../domain/repositories/bank_repository.dart';
import '../../infra/datasources/cache/local_datasource.dart';


class LocalBankAccountRepositoryImpl implements BankAccountRepository {
  final LocalDataSource localDataSource;

  LocalBankAccountRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<BankAccount>> getBankAccounts() async {
    List<String> data = await localDataSource.getAll('accounts');
    List<dynamic> bankAccounts = data.map((e) => jsonDecode(e)).toList();
    List<BankAccount> result = [];
    for (var element in bankAccounts) {
      result.add(BankAccount.fromMap(element));
    }
    return result;
  }

  @override
  saveBankAccount(BankAccount bankAccount) {
    String data = jsonEncode(bankAccount.toMap());
    localDataSource.save('accounts', data);
  }
}
