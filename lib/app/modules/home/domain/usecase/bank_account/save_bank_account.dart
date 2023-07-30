import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';
import '../../repositories/bank_repository.dart';
import '../../state/home_state.dart';


class SaveBankAccountListViewModelUseCase {
  final BankAccountRepository _bankAccountRepository;
  final HomeStates homeStates;

  SaveBankAccountListViewModelUseCase(
    this._bankAccountRepository,
    this.homeStates,
  );

  Future<void> call(BankAccount bankAccount) async {
    try {
      homeStates.onLoading();
      await _bankAccountRepository.saveBankAccount(bankAccount);
      var banks = await _bankAccountRepository.getBankAccountList();
      homeStates.onLoaded(banks);
    } catch (e) {
      homeStates.onError(e.toString());
    }
  }
}
