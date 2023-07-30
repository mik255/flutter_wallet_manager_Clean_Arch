import 'package:flutter/material.dart';
import 'package:wallet_manager/app/modules/transactions/domain/models/transaction.dart';

class TransactionMapper {
  Transaction toEntity(Map<String, dynamic> map) {
    return Transaction(
        // id: map['id'],
        amount: map['amount'],
        //description: map['description'],
        date: map['date'],
        type: TransactionType.DEBIT,
        category: TransactionCategory(
          name: map['category'],
          icon: Icons.ac_unit,
        ),
        name: map['description'],
        installments: '',
        bankName: '');
  }

  List<Transaction> getEntityList(List<dynamic> list) {
    List<Transaction> result = [];
    for (var element in list) {
      result.add(toEntity(element));
    }
    return result;
  }

  List<Map<String, dynamic>> toMap(List<Transaction> transactions) {
    return transactions
        .map((e) => {
              'amount': e.amount,
              'date': e.date,
              'category': e.category.name,
              'description': e.name,
              'installments': e.installments,
              'bankName': e.bankName,
              'type': e.type == TransactionType.DEBIT ? 'DEBIT' : 'CREDIT',
            })
        .toList();
  }


  List<Transaction> fromMapList(List<dynamic> jsonResult) {
   return jsonResult.map((e) => fromMap(e)).toList();
  }
  Transaction fromMap(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      date: json['date'],
      category: TransactionCategory(
        name: json['category'],
        icon: Icons.ac_unit,
      ),
      name: json['description'],
      installments: json['installments'],
      bankName: json['bankName'],
      type: json['type'] == 'DEBIT'
          ? TransactionType.DEBIT
          : TransactionType.CREDIT,
    );
  }
}
