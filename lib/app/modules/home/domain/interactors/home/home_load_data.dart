import 'package:flutter/cupertino.dart';
import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';
import '../../repositories/bank_repository.dart';
import '../../state/home_view_model.dart';

class HomeLoadDataInteractor extends ChangeNotifier implements HomeLoadDataViewModel {
  HomeLoadDataInteractor({
    required this.bankAccountRepository,
  });

  final BankAccountRepository bankAccountRepository;

  @override
  loadInitialData() async {
    loadingState = true;
    notifyListeners();
    bankAccounts = await bankAccountRepository.getBankAccounts();
    notifyListeners();
    loadingState = false;
  }

  @override
  bool loadingState = true;

  @override
  List<BankAccount> bankAccounts = [];
}
