import 'dart:math';
import 'package:wallet_manager/app/modules/home/domain/models/balance_type.dart';
import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';
import 'package:wallet_manager/app/modules/home/domain/models/category.dart';
import 'package:wallet_manager/app/modules/home/domain/models/category_results.dart';
import '../../../stateManager/bindHandler.dart';
import '../models/transaction.dart';
import '../repositories/bank_repository.dart';
import '../state/home_view_model.dart';
import '../viewmodels/home_view_model.dart';

class HomeViewModelImpl implements HomeViewModel {
  HomeViewModelImpl({
    required this.bankAccountRepository,
    required this.bind,
  });

  @override
  final BankAccountRepository bankAccountRepository;
  @override
  ViewBindingBase<HomeState> bind;

  final HomeLoadedState _homeLoadedState = HomeLoadedState(
    bankAccounts: [],
    results: Results(categories: []),
  );

  @override
  loadInitialData() async {
    bind.setState(HomeLoadingState());
    await bankAccountRepository.init();
    List<BankAccount> bankAccounts =
        await bankAccountRepository.getBankAccountList();
    bind.setState(
        _homeLoadedState.copyWith(
      bankAccounts: bankAccounts,
    ));
  }

  @override
  registerBankAccount(BankAccount bankAccount) async {
    bind.setState(HomeLoadingState());
    await bankAccountRepository.saveBankAccount(bankAccount);
    await loadInitialData();
  }

  @override
  calculateResults() {
    List<BankAccount> bankAccounts = _homeLoadedState.bankAccounts!;
    List<String> categories = bankAccounts
        .expand((element) => element.balanceTypes)
        .expand((element) => element.transactions)
        .map((e) => e.category.category)
        .toSet()
        .toList();
    List<CategoryResults> categoryResults = [];
    for (var element in categories) {
      for (var bankAccount in bankAccounts) {
        for (var balanceType in bankAccount.balanceTypes) {
          List<Transaction> transactions = balanceType.transactions
              .where((transaction) => transaction.category.category == element)
              .toList();
          if (transactions.isNotEmpty) {
            categoryResults.add(CategoryResults(
              name: element,
              color: Random().nextInt(0xffffffff),
              transactions: transactions,
            ));
          }
        }
      }
    }
    Results results = Results(categories: categoryResults);
    bind.setState(_homeLoadedState.copyWith(
      results: results,
    ));
  }
}
