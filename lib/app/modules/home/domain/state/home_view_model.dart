import '../../../stateManager/bindHandler.dart';
import '../models/bank_account.dart';
import '../models/category.dart';

abstract class HomeViewBinding extends ViewBindingBase<HomeState>{}

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<BankAccount>? bankAccounts;
  Results? results;

  HomeLoadedState({
    this.bankAccounts,
    this.results,
  });

  HomeLoadedState copyWith({
    List<BankAccount>? bankAccounts,
    Results? results,
  }) {
    return HomeLoadedState()
      ..bankAccounts = bankAccounts ?? this.bankAccounts
      ..results = results ?? this.results;
  }
}
