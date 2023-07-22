import 'dart:convert';

import 'package:wallet_manager/app/modules/home/data/datasources/local_datasource.dart';
import 'package:wallet_manager/app/modules/home/data/mappers/accountBank_mapper.dart';
import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';
import '../bank_datasource.dart';

class BankAccountLocalDataSource implements BankAccountDataSource {
  final LocalDataSource localDataSource;

  BankAccountLocalDataSource({required this.localDataSource});

  @override
  Future<BankAccount> getBankAccount(String id) async {
    List<String> result = await localDataSource.getList('accounts',);
    var jsonBankAccount = result.firstWhere((element) {
      var jsonResult = json.decode(element);
      return jsonResult['id'] == id;
    });
    var dataMap = json.decode(jsonBankAccount);
    return BankAccountDto().fromLocalJson(dataMap);
  }

  @override
  Future<List<BankAccount>> getBankAccountList() async {
    var result = await localDataSource.getList('accounts');
    return result.map((e) {
      var jsonResult = json.decode(e);
      return BankAccountDto().fromLocalJson(jsonResult);
    }).toList();
  }

  @override
  Future<void> init() async {
    await localDataSource.init();
  }

  @override
  saveBankAccount(BankAccount bankAccount) async {
    var json = jsonEncode(BankAccountDto().toMap(bankAccount));
    List<String> list = await localDataSource.getList('accounts');
    list.add(json);
    await localDataSource.saveList('accounts', list);
  }
}
