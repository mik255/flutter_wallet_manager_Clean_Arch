import 'dart:math';

import 'package:wallet_manager/app/modules/home/domain/models/category.dart';

import '../../../home/domain/models/category_results.dart';
import '../../../transactions/domain/models/transaction.dart';
import '../states/results_states.dart';

class CalculateResultsUserCase {
  CalculateResultsUserCase({required this.resultsStates});

  ResultsStates resultsStates;

  Results call(List<Transaction> transactions) {
    var results = Results(categories: []);
    List<String> categories = transactions.map((e) => e.category.name).toSet().toList();
    for (var category in categories) {
      var categoryResults = CategoryResults(
        name: category,
        color: Random().nextInt(0xffffffff),
        transactions: transactions
            .where(
              (element) => element.category.name == category,
            )
            .toList(),
      );
      results.categories.add(categoryResults);
    }

    results.calculate();
    resultsStates.onCalculate(results);
    return results;
  }
}
