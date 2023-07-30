import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';

import '../../repositories/bank_repository.dart';
import '../../state/home_state.dart';

class GetBankAccountListViewModelUseCase {
  final BankAccountRepository _bankAccountRepository;
  late HomeStates homeStates;
  List<BankAccount> banksState = [];

  GetBankAccountListViewModelUseCase(
    this._bankAccountRepository,
  );

  Future<void> call() async {
    try {
      homeStates.onLoading();
      banksState = await _bankAccountRepository.getBankAccountList();
      homeStates.onLoaded(banksState);
    } catch (e) {
      homeStates.onError(e.toString());
    }
  }
}
