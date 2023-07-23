import '../../../../stateManager/bindHandler.dart';
import '../../repositories/bank_repository.dart';
import '../../state/home_view_model.dart';

class GetBankAccountListViewModelUseCase {
  final BankAccountRepository _bankAccountRepository;
  final ViewBindingBase<HomeState> bind;

  GetBankAccountListViewModelUseCase(this._bankAccountRepository, this.bind);

  Future<void> call() async {
    try {
      bind.setState(HomeLoadingState());
      var banks = await _bankAccountRepository.getBankAccountList();
      bind.setState(homeLoadedState.copyWith(
        bankAccounts: banks,
      ));
    } catch (e) {
      bind.setState(HomeErrorState(message: e.toString()));
    }
  }
}
