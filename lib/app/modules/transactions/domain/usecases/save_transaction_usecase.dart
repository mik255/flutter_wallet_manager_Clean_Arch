import '../models/transaction.dart';
import '../repositories/transaction_repository.dart';

class SaveTransactionUseCase {
  final TransactionsRepository repository;

  SaveTransactionUseCase(this.repository);

  Future<void> call(Transaction transaction) async {
    return await repository.registerManualTransaction(transaction);
  }
}
