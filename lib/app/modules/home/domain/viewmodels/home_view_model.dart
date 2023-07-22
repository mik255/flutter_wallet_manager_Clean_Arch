import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';
import '../../../stateManager/bindHandler.dart';
import '../repositories/bank_repository.dart';
import '../state/home_view_model.dart';

abstract class HomeViewModel {
  BankAccountRepository get bankAccountRepository;
  late ViewBindingBase<HomeState> bind;
  loadInitialData();
  registerBankAccount(BankAccount bankAccount);
  calculateResults();
}

