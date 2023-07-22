import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transaction {
  String name;
  String date;
  num amount;
  String installments;
  String bankName;
  TransactionCategory category;
  TransactionType type;

  Transaction({
    required this.category,
    required this.name,
    required this.date,
    required this.amount,
    required this.installments,
    required this.bankName,
    required this.type,
  });

  toMap() {
    return {
      'name': name,
      'date': date,
      'amount': amount,
      'installments': installments,
      'bankName': bankName,
      'category': category.category,
      'type': type,
    };
  }

}

enum TransactionType {
  CREDIT,
  DEBIT,
}

class TransactionCategory {
  String category;
  IconData icon;

  TransactionCategory({
    required this.category,
    required this.icon,
  });
}


