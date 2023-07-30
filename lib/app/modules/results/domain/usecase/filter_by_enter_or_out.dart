import 'dart:math';

import 'package:wallet_manager/app/modules/home/domain/models/category.dart';

import '../../../home/domain/models/category_results.dart';
import '../../../transactions/domain/models/transaction.dart';


class FilterCalculateResultsUserCase {
  Results call(List<Transaction> transactions, bool? isEnter) {
    var results = Results(categories: []);
    List<String> categories = transactions.map((e) => e.category.name).toSet().toList();
    for (var category in categories) {
        transactions = transactions
            .where(
              (element) => element.isEnter == isEnter,
            )
            .toList();
      var categoryResults = CategoryResults(
        name: category,
        color: Random().nextInt(0xffffffff),
        transactions: transactions,
      );
      results.categories.add(categoryResults);
    }
    return results;
  }
}
