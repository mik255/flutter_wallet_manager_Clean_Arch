

import 'category_results.dart';

class Results {
  final List<CategoryResults> categories;

  Results({
    required this.categories,
  });
  num get totalValue {
    return categories.map((e) => e.totalValue).reduce((a, b) => a + b);
  }
}