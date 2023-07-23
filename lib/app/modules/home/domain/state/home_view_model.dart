import 'package:wallet_manager/app/modules/home/domain/models/expense.dart';
import '../../../stateManager/bindHandler.dart';
import '../models/bank_account.dart';
import '../models/category.dart';

abstract class HomeViewBinding extends ViewBindingBase<HomeState>{}

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  String? message;

  HomeErrorState({this.message});
}

class HomeLoadedState extends HomeState {
  List<BankAccount>? bankAccounts;
  List<Expense>? expenses;
  Results? results;

  HomeLoadedState({
    this.bankAccounts,
    this.results,
    this.expenses
  });

  HomeLoadedState copyWith({
    List<BankAccount>? bankAccounts,
    List<Expense>? expenses,
    Results? results,
  }) {
    return HomeLoadedState()
      ..bankAccounts = bankAccounts ?? this.bankAccounts
      ..expenses = expenses ?? this.expenses
      ..results = results ?? this.results;
  }
}

HomeLoadedState homeLoadedState = HomeLoadedState(
  bankAccounts: [],
  results: Results(categories: []),
  expenses: [],
);
