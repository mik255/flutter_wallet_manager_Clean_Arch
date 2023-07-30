import 'package:wallet_manager/app/modules/transactions/domain/models/transaction.dart';

class CategoryResults {
  CategoryResults({
    required this.name,
    required this.color,
    required this.transactions,
  });

  String name;
  int color;
  List<Transaction> transactions;

  num get totalValue {
    return transactions.map((e) => e.amount).reduce((a, b) => a + b);
  }

}
