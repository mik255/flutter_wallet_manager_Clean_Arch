import 'category_results.dart';

class Results {
  final List<CategoryResults> categories;

  Results({
    required this.categories,
  });

  double totalValue = 0;

  num calculate() {
    if(categories.isEmpty) return 0;
    return totalValue = categories.map((e) => e.totalValue).reduce((a, b) => a + b).toDouble();
  }
}
