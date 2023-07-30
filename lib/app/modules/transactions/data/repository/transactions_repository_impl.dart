import 'package:wallet_manager/app/modules/transactions/domain/repositories/transaction_repository.dart';
import '../../domain/models/transaction.dart';
import '../datasources/local_datasource.dart';

class TransactionRepositoryImpl implements TransactionsRepository {
  final TransactionsDataSource dataSource;

  TransactionRepositoryImpl(this.dataSource);

  @override
  Future<List<Transaction>> getTransactions() async {
    return await dataSource.getTransactions();
  }

  @override
  Future<void> registerManualTransaction(Transaction transaction) async{
    await dataSource.registerManualTransaction(transaction);
  }
}
