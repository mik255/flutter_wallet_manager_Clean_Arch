import 'dart:convert';
import 'package:wallet_manager/app/core/data/datasources/local_datasource.dart';
import 'package:wallet_manager/app/modules/transactions/data/mapper/transaction_mapper.dart';
import 'package:wallet_manager/app/modules/transactions/data/datasources/local_datasource.dart';
import 'package:wallet_manager/app/modules/transactions/domain/models/transaction.dart';

class LocalTransactionDataSourceImpl extends TransactionsDataSource {
  LocalDTO localDTO;

  LocalTransactionDataSourceImpl(this.localDTO);

  @override
  Future<List<Transaction>> getTransactions() async {
    List<String> results = await localDTO.getList('transactions');
    var dataJson = results.map((e) => json.decode(e)).toList();
    return TransactionMapper().fromMapList(dataJson);
  }

  @override
  Future<void> registerManualTransaction(Transaction transaction) async{
    var list = await getTransactions();
    list.add(transaction);
    var data = TransactionMapper().toMap(list);
    localDTO.saveList('transactions', data.map((e) => jsonEncode(e)).toList());
  }
}
