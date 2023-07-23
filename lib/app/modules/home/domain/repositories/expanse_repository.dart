import 'package:wallet_manager/app/modules/home/domain/models/expense.dart';

abstract class ExpanseRepository {
  Future<List<Expense>> getExpenseList();

  saveExpenseAccount(Expense expense);

  Future<void> init();
}
