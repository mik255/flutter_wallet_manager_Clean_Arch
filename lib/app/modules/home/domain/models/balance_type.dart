import 'package:wallet_manager/app/modules/home/domain/models/transaction.dart';

enum BalanceTypeEnum { CHECKING_ACCOUNT, SAVINGS_ACCOUNT, CREDIT_CARD }

extension GetName on BalanceTypeEnum {
  String get getName {
    switch (this) {
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
  toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'balanceType': balanceType,
      'logo': logo,
      'transactions': transactions.map((e) => e.toMap()).toList(),
      'limit': limit,
      'availableLimit': availableLimit,
      'balanceCloseDate': balanceCloseDate,
      'balanceDueDate': balanceDueDate,
    };
  }
}
