import '../models/transaction.dart';

abstract class TransactionsRepository {
  Future<List<Transaction>> getTransactions();
  Future<void> registerManualTransaction(Transaction transaction);
}
