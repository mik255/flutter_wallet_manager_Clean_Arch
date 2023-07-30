import 'package:wallet_manager/app/modules/transactions/data/mapper/transaction_mapper.dart';
import 'package:wallet_manager/app/modules/home/domain/models/balance_type.dart';

class BalanceTypesMapper {
  BalanceType toEntity(
    Map<String, dynamic> map,
    Map<String, dynamic> transactionsMap,
  ) {
    return BalanceType(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
      balanceType: _getBalanceType(map['subtype']),
      logo: '',
      transactions: TransactionMapper().getEntityList(transactionsMap['results'] as List<dynamic>),
      limit: map['creditData']?['creditLimit'],
      availableLimit: map['creditData']?['availableCreditLimit'],
      balanceCloseDate: map['creditData']?['balanceCloseDate'],
      balanceDueDate: map['creditData']?['balanceDueDate'],
    );
  }

  List<BalanceType> getEntityList(
    Map<String, dynamic> account,
    Map<String, dynamic> transactions,
  ) {
    List<BalanceType> result = [];
    for (var element in account['results']) {
      result.add(toEntity(
        element,
        transactions,
      ));
    }
    return result;
  }

  BalanceTypeEnum _getBalanceType(String balanceType) {
    switch (balanceType) {
      case 'CHECKING_ACCOUNT':
        return BalanceTypeEnum.CHECKING_ACCOUNT;
      case 'SAVINGS_ACCOUNT':
        return BalanceTypeEnum.SAVINGS_ACCOUNT;
      case 'CREDIT_CARD':
        return BalanceTypeEnum.CREDIT_CARD;
      default:
        return BalanceTypeEnum.CHECKING_ACCOUNT;
    }
  }

  List<Map<String, Object>> toMap(List<BalanceType> balanceTypes) {
    return balanceTypes
        .map((e) => {
              'id': e.id,
              'name': e.name,
              'balance': e.balance,
              'subtype': e.balanceType.name,
              'logo': e.logo,
              'creditData': {
                'creditLimit': e.limit,
                'availableCreditLimit': e.availableLimit,
                'balanceCloseDate': e.balanceCloseDate,
                'balanceDueDate': e.balanceDueDate,
              },
              'transactions': TransactionMapper().toMap(e.transactions),
            })
        .toList();
  }

  fromMapList(List<dynamic> jsonResult) {
    List<BalanceType> result = [];
    for (var element in jsonResult) {
      result.add(fromMap(element));
    }
    return result;
  }

  fromMap(Map<String, dynamic> jsonResult) {
    return BalanceType(
      id: jsonResult['id'],
      name: jsonResult['name'],
      balance: jsonResult['balance'],
      balanceType: _getBalanceType(jsonResult['subtype']),
      logo: '',
      transactions: TransactionMapper().fromMapList(jsonResult['transactions']),
      limit: jsonResult['creditData']?['creditLimit'],
      availableLimit: jsonResult['creditData']?['availableCreditLimit'],
      balanceCloseDate: jsonResult['creditData']?['balanceCloseDate'],
      balanceDueDate: jsonResult['creditData']?['balanceDueDate'],
    );
  }
}
