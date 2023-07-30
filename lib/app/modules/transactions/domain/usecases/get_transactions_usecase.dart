import '../models/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionsRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<List<Transaction>> call() async {
    return await repository.getTransactions();
  }
}
