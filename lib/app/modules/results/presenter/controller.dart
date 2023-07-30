import 'package:get_it/get_it.dart';
import 'package:wallet_manager/app/modules/home/domain/models/category.dart';
import 'package:wallet_manager/app/modules/results/domain/states/results_states.dart';
import '../../home/domain/usecase/bank_account/get_banks_account.dart';
import '../../transactions/domain/usecases/get_transactions_usecase.dart';
import '../domain/usecase/calculate_results.dart';

class ResultsController {
  final ResultsStates store;
  late CalculateResultsUserCase calculateResultsUserCase;

  ResultsController(this.store) {
    calculateResultsUserCase = CalculateResultsUserCase(resultsStates: store);
  }

  Future<Results> calculate() async{
    var getBankAccountListViewModelUseCase = GetIt.I<GetBankAccountListViewModelUseCase>();
    var getTransactionsUseCase = GetIt.I<GetTransactionsUseCase>();
    var bankAccounts = getBankAccountListViewModelUseCase.banksState;
    var transactions = await getTransactionsUseCase.call();
    return calculateResultsUserCase.call([
      ...bankAccounts
          .expand((element) => element.balanceTypes.expand(
                (element) => element.transactions,
              ))
          .toList(),
      ...transactions
    ],);
  }
}
