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
      'category': category.name,
      'type': type,
    };
  }
 bool get isEnter{
    return type==TransactionType.CREDIT;
 }
}

enum TransactionType {
  CREDIT,
  DEBIT,
}

class TransactionCategory {
  String name;
  IconData icon;

  TransactionCategory({
    required this.name,
    required this.icon,
  });
}


