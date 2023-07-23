import 'package:wallet_manager/app/modules/home/domain/models/expense.dart';
import '../../domain/repositories/expanse_repository.dart';
import '../datasources/local/expense_datasource.dart';

class ExpenseRepositoryImpl implements ExpanseRepository {
  final ExpenseDataSource dataSource;

  ExpenseRepositoryImpl(this.dataSource);

  @override
  Future<List<Expense>> getExpenseList() async {
    return await dataSource.getExpenseList();
  }

  @override
  Future<void> init() async {
    await dataSource.init();
  }

  @override
  saveExpenseAccount(Expense expense) async {
      return await dataSource.saveExpenseAccount(expense);
  }
}
