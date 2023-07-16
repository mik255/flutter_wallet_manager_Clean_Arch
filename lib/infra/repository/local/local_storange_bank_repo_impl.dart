import 'dart:convert';
import 'package:wallet_manager/domain/models/bank_account.dart';
import '../../../domain/repositories/bank_repository.dart';
import '../../../domain/repositories/local_storange_interface.dart';


class LocalBankAccountRepositoryImpl implements BankAccountRepository {
  final LocalStorageInterface localStorageInterface;

  LocalBankAccountRepositoryImpl({
    required this.localStorageInterface,
  });

  @override
  Future<List<BankAccount>> getBankAccounts() async {
    List<String> data = await localStorageInterface.getAll('accounts');
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
    localStorageInterface.save('accounts', data);
  }
}
