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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'amount': amount,
      'installments': installments,
      'bankName': bankName,
      'category': category.name,
      'type': type == TransactionType.CREDIT ? 'CREDIT' : 'DEBIT',
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      category: TransactionCategory.values.firstWhere(
          (element) => element.name == map['category'],
          orElse: () => TransactionCategory.OTHERS),
      name: map['name'] as String,
      date: map['date'] as String,
      amount: map['amount'] as num,
      installments: map['installments'] as String,
      bankName: map['bankName'] as String,
      type: map['type'] == 'CREDIT'
          ? TransactionType.CREDIT
          : TransactionType.DEBIT,
    );
  }
}

enum TransactionType {
  CREDIT,
  DEBIT,
}

enum TransactionCategory {
  INCOME,
  LOANS_AND_FINANCING,
  LOANS,
  INVESTMENTS,
  SAME_PERSON_TRANSFER,
  TRANSFERS,
  CREDIT_CARD_PAYMENT,
  LEGAL_OBLIGATIONS,
  SERVICES,
  TELECOMMUNICATIONS,
  EDUCATION,
  WELLNESS_AND_FITNESS,
  TICKETS,
  SHOPPING,
  DIGITAL_SERVICES,
  GROCERIES,
  FOOD_AND_DRINKS,
  TRAVEL,
  DONATIONS,
  GAMBLING,
  TAXES,
  BANK_FEES,
  HOUSING,
  UTILITIES,
  HOUSEWARE,
  HEALTHCARE,
  TRANSPORTATION,
  INSURANCE,
  LEISURE,
  OTHERS,
  AUTOMOTIVE,
}

extension GetTransactionCategory on TransactionCategory {
  String get name {
    switch (this) {
      case TransactionCategory.INCOME:
        return 'Renda';
      case TransactionCategory.LOANS_AND_FINANCING:
        return 'Empréstimos e Financiamentos';
      case TransactionCategory.LOANS:
        return 'Empréstimos';
      case TransactionCategory.INVESTMENTS:
        return 'Investimentos';
      case TransactionCategory.SAME_PERSON_TRANSFER:
        return 'Transferência para Mesma Pessoa';
      case TransactionCategory.TRANSFERS:
        return 'Transferências';
      case TransactionCategory.CREDIT_CARD_PAYMENT:
        return 'Pagamento de Cartão de Crédito';
      case TransactionCategory.LEGAL_OBLIGATIONS:
        return 'Obrigações Legais';
      case TransactionCategory.SERVICES:
        return 'Serviços';
      case TransactionCategory.TELECOMMUNICATIONS:
        return 'Telecomunicações';
      case TransactionCategory.EDUCATION:
        return 'Educação';
      case TransactionCategory.WELLNESS_AND_FITNESS:
        return 'Bem-estar e Fitness';
      case TransactionCategory.TICKETS:
        return 'Ingressos';
      case TransactionCategory.SHOPPING:
        return 'Compras';
      case TransactionCategory.DIGITAL_SERVICES:
        return 'Serviços Digitais';
      case TransactionCategory.GROCERIES:
        return 'Alimentos';
      case TransactionCategory.FOOD_AND_DRINKS:
        return 'Comida e Bebidas';
      case TransactionCategory.TRAVEL:
        return 'Viagem';
      case TransactionCategory.DONATIONS:
        return 'Doações';
      case TransactionCategory.GAMBLING:
        return 'Jogos de Azar';
      case TransactionCategory.TAXES:
        return 'Impostos';
      case TransactionCategory.BANK_FEES:
        return 'Taxas Bancárias';
      case TransactionCategory.HOUSING:
        return 'Habitação';
      case TransactionCategory.UTILITIES:
        return 'Utilidades';
      case TransactionCategory.HOUSEWARE:
        return 'Utensílios Domésticos';
      case TransactionCategory.HEALTHCARE:
        return 'Saúde';
      case TransactionCategory.TRANSPORTATION:
        return 'Transporte';
      case TransactionCategory.INSURANCE:
        return 'Seguros';
      case TransactionCategory.LEISURE:
        return 'Lazer';
      case TransactionCategory.OTHERS:
        return 'Outros';
      default:
        return 'Desconhecido';
    }
  }
}

extension GetTransactionIcon on TransactionCategory {
  IconData get icon {
    switch (this) {
      case TransactionCategory.INCOME:
        return Icons.attach_money;
      case TransactionCategory.LOANS_AND_FINANCING:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.LOANS:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.INVESTMENTS:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.SAME_PERSON_TRANSFER:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.TRANSFERS:
        return Icons.compare_arrows_sharp;
      case TransactionCategory.CREDIT_CARD_PAYMENT:
        return Icons.payments_outlined;
      case TransactionCategory.LEGAL_OBLIGATIONS:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.SERVICES:
        return Icons.miscellaneous_services;
      case TransactionCategory.TELECOMMUNICATIONS:
        return CupertinoIcons.phone;
      case TransactionCategory.EDUCATION:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.WELLNESS_AND_FITNESS:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.TICKETS:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.SHOPPING:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.DIGITAL_SERVICES:
        return Icons.computer;
      case TransactionCategory.GROCERIES:
        return Icons.fastfood;
      case TransactionCategory.FOOD_AND_DRINKS:
        return Icons.fastfood;
      case TransactionCategory.TRAVEL:
        return Icons.place;
      case TransactionCategory.DONATIONS:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.GAMBLING:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.TAXES:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.BANK_FEES:
        return Icons.currency_exchange_rounded;
      case TransactionCategory.HOUSING:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.UTILITIES:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.HOUSEWARE:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.HEALTHCARE:
        return CupertinoIcons.money_dollar_circle;
      case TransactionCategory.TRANSPORTATION:
        return CupertinoIcons.train_style_one;
      case TransactionCategory.INSURANCE:
      default:
        return CupertinoIcons.money_dollar_circle;
    }
  }
}
