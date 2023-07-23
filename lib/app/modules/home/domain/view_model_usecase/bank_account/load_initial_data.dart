import 'package:wallet_manager/app/modules/home/domain/models/category.dart';
import 'package:wallet_manager/app/modules/home/domain/view_model_usecase/bank_account/get_banks_account.dart';

import '../../../../stateManager/bindHandler.dart';
import '../../repositories/bank_repository.dart';
import '../../state/home_view_model.dart';
import '../expense/get_expense_list.dart';

class InitiLoadDataViewModelUseCase {
  final BankAccountRepository _bankAccountRepository;
  final ViewBindingBase<HomeState> bind;
  GetBankAccountListViewModelUseCase getBankAccountListViewModelUseCase;
  GetExpanseListViewModelUseCase getExpanseListViewModelUseCase;

  InitiLoadDataViewModelUseCase(
    this._bankAccountRepository,
    this.bind,
    this.getBankAccountListViewModelUseCase,
    this.getExpanseListViewModelUseCase,
  );

  Future<void> call() async {
    try {
      bind.setState(HomeLoadingState());
      await _bankAccountRepository.init();
      homeLoadedState = HomeLoadedState(
        bankAccounts: [],
        expenses: [],
        results: Results(
          categories: [],
        ),
      );
      await getBankAccountListViewModelUseCase.call();
      await getExpanseListViewModelUseCase.call();
    } catch (e) {
      bind.setState(HomeErrorState(
        message: e.toString(),
      ));
    }
  }
}
