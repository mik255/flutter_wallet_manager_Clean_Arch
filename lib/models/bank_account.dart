import 'package:wallet_manager/models/transaction.dart';

class BankAccount{
  String accountId;
  String name;
  List<BalanceType> balanceTypes;

  BankAccount({
    required this.accountId,
    required this.name,
    required this.balanceTypes,
  });

  Map<String,dynamic> toJson() {
    return {
      'accountId': accountId,
      'name': name,
      'balanceTypes': balanceTypes.map((e) => e.toMap()).toList(),
    };
  }
  factory BankAccount.fromJson(Map<String, dynamic> map) {
    return BankAccount(
      accountId: map['accountId'] as String,
      name: map['name'] as String,
      balanceTypes: (map['balanceTypes'] as List<dynamic>)
          .map((e) => BalanceType.fromMap(e))
          .toList(),
    );
  }
}
// ignore: constant_identifier_names
enum BalanceTypeEnum { SAVINGS_ACCOUNT, CHECKINGS_ACCOUNT, CREDIT_CARD, }
class BalanceType {
  String id;
  String name;
  double balance = 0;
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
  });

  Map<String, dynamic> toMap() {
    return {
      'accountId': id,
      'name': name,
      'balance': balance,
      'balanceType': balanceType.name,
      'logo': logo,
      'transactions': transactions.map((e) => e.toMap()).toList(),
    };
  }

  factory BalanceType.fromMap(Map<String, dynamic> map) {
    return BalanceType(
      id: map['id'] as String,
      name: map['name'] as String,
      balance: map['balance'] as double,
      balanceType: BalanceTypeEnum.values.firstWhere(
          (e) => e.name == map['balanceType'] as String),
      logo: map['logo'] as String,
      transactions: (map['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromMap(e))
          .toList(),
    );
  }

}
