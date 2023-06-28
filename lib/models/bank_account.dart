import 'package:wallet_manager/models/transaction.dart';

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
enum BalanceTypeEnum { CHECKING_ACCOUNT, SAVING_ACCOUNT,CREDIT_CARD }
class BalanceType {
  String id;
  String name;
  num balance = 0;
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
      id: map['accountId'] as String,
      name: map['name'] as String,
      balance: map['balance'] as num,
      balanceType: BalanceTypeEnum.values.firstWhere(
          (e) => e.name == map['balanceType'] as String),
      logo: map['logo'] as String,
      transactions: (map['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromMap(e))
          .toList(),
    );
  }

}
