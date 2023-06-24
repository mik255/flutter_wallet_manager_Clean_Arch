
import 'dart:io';

import 'item_billing.dart';

class Billing {
  String name;
  List<BillingItem> items;
  File image;

//<editor-fold desc="Data Methods">
  Billing({
    required this.name,
    required this.items,
    required this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Billing &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          items == other.items &&
          image == other.image);

  @override
  int get hashCode => name.hashCode ^ items.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'Billing{ name: $name, items: $items, image: $image,}';
  }

  Billing copyWith({
    String? name,
    List<BillingItem>? items,
    File? image,
  }) {
    return Billing(
      name: name ?? this.name,
      items: items ?? this.items,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'items': items,
      'image': image,
    };
  }

  factory Billing.fromMap(Map<String, dynamic> map) {
    return Billing(
      name: map['name'] as String,
      items: map['items'] as List<BillingItem>,
      image: map['image'] as File,
    );
  }

//</editor-fold>
}