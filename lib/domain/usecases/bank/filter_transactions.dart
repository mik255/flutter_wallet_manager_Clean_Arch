import 'package:wallet_manager/domain/usecases/instances.dart';

class FilterTransactions {
  void call({required String filter}) async {
    if(filter.isEmpty){
      currentBankTransactionsFiltered = currentBankAccounts
          .expand((element) => element.balanceTypes)
          .expand((element) => element.transactions).toList();
      return;
    }
    currentBankTransactionsFiltered = currentBankAccounts
        .expand((element) => element.balanceTypes)
        .expand((element) => element.transactions)
        .where((element) => element.toMap().contains(filter)).toList();
  }
}
