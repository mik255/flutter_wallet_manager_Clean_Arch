import '../../domain/models/transaction.dart';

abstract class TransactionsDataSource {
  Future<List<Transaction>> getTransactions();
  Future<void> registerManualTransaction(Transaction transaction);
}
