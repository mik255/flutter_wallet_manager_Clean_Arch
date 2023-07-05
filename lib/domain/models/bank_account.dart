

import 'package:wallet_manager/domain/models/transaction.dart';

class BankAccount{
  List<BalanceType> balanceTypes;

  BankAccount({
    required this.balanceTypes,
  });

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


}
