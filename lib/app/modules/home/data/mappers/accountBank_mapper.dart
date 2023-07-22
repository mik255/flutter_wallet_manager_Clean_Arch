import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';

import 'balanceTypesMapper.dart';

class BankAccountDto {
  /// o [item] são os dados da conta bancária, um user pode ter várias contas que são chamadas de conector
  /// o [balanceTypes] são os tipos de saldo que a conta bancária tem, como saldo, limite, etc.
  /// o [transactions] são as transações que a conta bancária tem, como saldo, limite, etc.
  BankAccount plugglyServiceToEntity(
    Map<String, dynamic> item,
    Map<String, dynamic> balanceTypes,
    Map<String, dynamic> transactions,
  ) {
    return BankAccount(
      id: item['connector']['id'].toString(),
      name: item['connector']['name'],
      logo: item['connector']['imageUrl'],
      owner: 'owner',
      balanceTypes: BalanceTypesMapper().getEntityList(
        balanceTypes,
        transactions,
      ),
    );
  }

  BankAccount fromLocalJson(jsonResult) {
    return BankAccount(
      id: (jsonResult['id']).toString(),
      name: jsonResult['name'],
      logo: jsonResult['logo'],
      owner: jsonResult['owner'],
      balanceTypes: BalanceTypesMapper().fromMapList(jsonResult['balanceTypes']),
    );
  }

  Map<String,dynamic> toMap(BankAccount bankAccount){
    return {
      'id':bankAccount.id,
      'name':bankAccount.name,
      'logo':bankAccount.logo,
      'owner':bankAccount.owner,
      'balanceTypes':BalanceTypesMapper().toMap(bankAccount.balanceTypes),
    };
  }
}
