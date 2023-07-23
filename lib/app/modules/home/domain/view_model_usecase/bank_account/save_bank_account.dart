import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';

import '../../../../stateManager/bindHandler.dart';
import '../../repositories/bank_repository.dart';
import '../../state/home_view_model.dart';

class SaveBankAccountListViewModelUseCase {
  final BankAccountRepository _bankAccountRepository;
  final ViewBindingBase<HomeState> bind;

  SaveBankAccountListViewModelUseCase(
    this._bankAccountRepository,
    this.bind,
  );

  Future<void> call(BankAccount bankAccount) async {
    try {
      bind.setState(HomeLoadingState());
      await _bankAccountRepository.saveBankAccount(bankAccount);
      var banks = await _bankAccountRepository.getBankAccountList();
      bind.setState(homeLoadedState.copyWith(
        bankAccounts: banks,
      ));
    } catch (e) {
      bind.setState(HomeErrorState(message: e.toString()));
    }
  }
}
