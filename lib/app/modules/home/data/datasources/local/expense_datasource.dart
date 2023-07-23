import 'dart:convert';
import 'package:wallet_manager/app/modules/home/data/mappers/expense_mapper.dart';
import 'package:wallet_manager/app/modules/home/domain/models/expense.dart';
import '../local_datasource.dart';

abstract class ExpenseDataSource {
  Future<void> init();
  Future<List<Expense>> getExpenseList();
  saveExpenseAccount(Expense expense);
}

class ExpenseDataSourceImpl implements ExpenseDataSource {
  LocalDataSource localDataSource;

  ExpenseDataSourceImpl(this.localDataSource);

  @override
  Future<List<Expense>> getExpenseList() async {
    var localResult = await localDataSource.getList('expenses');
    var expenseList = localResult
        .map((e) => ExpenseMapper().fromMapToEntity(
              jsonDecode(e),
            ))
        .toList();
    return expenseList;
  }

  @override
  saveExpenseAccount(Expense expense) async {
    var expenseMap = ExpenseMapper().toMap(expense);
    List<String> getExpenseList = await localDataSource.getList('expenses');
    getExpenseList.add(jsonEncode(expenseMap));
    localDataSource.saveList('expenses', getExpenseList);
    return expense;
  }

  @override
  Future<void> init() async{
    await localDataSource.init();
  }
}

