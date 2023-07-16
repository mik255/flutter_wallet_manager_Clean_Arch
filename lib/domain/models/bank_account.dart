import 'package:wallet_manager/domain/models/transaction.dart';

import 'balance_type.dart';

class BankAccount {
  String id;
  List<BalanceType> balanceTypes;
  String name;
  String owner;
  String logo;

//<editor-fold desc="Data Methods">
  BankAccount({
    required this.balanceTypes,
    required this.name,
    required this.owner,
    required this.logo,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'balanceTypes': balanceTypes.map((e) => e.toMap()).toList(),
      'name': name,
      'owner': owner,
      'logo': logo,
    };
  }

  factory BankAccount.fromMap(Map<String, dynamic> map) {
    return BankAccount(
      id: map['id'] as String,
      balanceTypes: map['balanceTypes'] as List<BalanceType>,
      name: map['name'] as String,
      owner: map['owner'] as String,
      logo: map['logo'] as String,
    );
  }

}

