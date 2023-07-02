

import 'package:wallet_manager/domain/models/transaction.dart';

class BankAccount{
  List<BalanceType> balanceTypes;

  BankAccount({
    required this.balanceTypes,
  });

  Map<String,dynamic> toJson() {
    return {
      'balanceTypes': balanceTypes.map((e) => e.toMap()).toList(),
    };
  }
  factory BankAccount.fromJson(Map<String, dynamic> map) {
    return BankAccount(
      balanceTypes: (map['balanceTypes'] as List<dynamic>)
          .map((e) => BalanceType.fromMap(e))
          .toList(),
    );
  }
}
// ignore: constant_identifier_names
enum BalanceTypeEnum { CHECKING_ACCOUNT, SAVINGS_ACCOUNT,CREDIT_CARD }

extension GetName on BalanceTypeEnum{
  String get getName{
    switch(this){
      case BalanceTypeEnum.CHECKING_ACCOUNT:
        return 'Saldo em conta';
      case BalanceTypeEnum.SAVINGS_ACCOUNT:
        return 'Saldo em poupança';
      case BalanceTypeEnum.CREDIT_CARD:
        return 'Saldo em crédito';
    }
  }
}

class BalanceType {
  String id;
  String name;
  String? balanceCloseDate;
  String? balanceDueDate;
  num balance = 0;
  num? limit;
  num? availableLimit;
  BalanceTypeEnum balanceType;
  String logo;
  List<Transaction> transactions;

  BalanceType({
    required this.id,
    required this.name,
    required this.balance,
    required this.balanceType,
    required this.logo,
    required this.transactions,
    required this.limit,
    required this.availableLimit,
    required this.balanceCloseDate,
    required this.balanceDueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'accountId': id,
      'name': name,
      'balance': balance,
      'balanceType': balanceType.name,
      'logo': logo,
      'transactions': transactions.map((e) => e.toMap()).toList(),
      'limit': limit,
      'availableLimit': availableLimit,
      'balanceCloseDate': balanceCloseDate,
      'balanceDueDate': balanceDueDate,
    };
  }

  factory BalanceType.fromMap(Map<String, dynamic> map) {
    return BalanceType(
      id: map['accountId'] as String,
      name: map['name'] as String,
      balance: map['balance'] as num,
      limit: map['limit'] as num?,
      availableLimit: map['availableLimit'] as num?,
      balanceType: BalanceTypeEnum.values.firstWhere(
          (e) => e.name == map['balanceType'] as String),
      logo: map['logo'] as String,
      transactions: (map['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromMap(e))
          .toList(),
      balanceCloseDate: map['balanceCloseDate'] as String,
      balanceDueDate: map['balanceDueDate'] as String,
    );
  }

}
