enum BillingCategory {food,card,other}

class BillingItem{
  String name;
  double price;
  double totalPrice = 0;
  int installments;
  BillingCategory category;

//<editor-fold desc="Data Methods">
  BillingItem({
    required this.name,
    required this.price,
    required this.installments,
    required this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillingItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          price == other.price &&
          installments == other.installments &&
          category == other.category);

  @override
  int get hashCode =>
      name.hashCode ^
      price.hashCode ^
      installments.hashCode ^
      category.hashCode;

  @override
  String toString() {
    return 'BillingItem{ name: $name, price: $price, installments: $installments, category: $category,}';
  }

  BillingItem copyWith({
    String? name,
    double? price,
    int? installments,
    BillingCategory? category,
  }) {
    return BillingItem(
      name: name ?? this.name,
      price: price ?? this.price,
      installments: installments ?? this.installments,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'installments': installments,
      'category': category,
    };
  }

  factory BillingItem.fromMap(Map<String, dynamic> map) {
    return BillingItem(
      name: map['name'] as String,
      price: map['price'] as double,
      installments: map['installments'] as int,
      category: map['category'] as BillingCategory,
    );
  }

  getTotal(){
    return totalPrice = price*installments;
  }



}