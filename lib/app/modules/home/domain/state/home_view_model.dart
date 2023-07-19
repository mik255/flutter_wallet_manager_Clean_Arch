import 'package:flutter/cupertino.dart';
import '../models/bank_account.dart';
import '../models/category.dart';

abstract class HomeState {
  void setState(HomeState state) {}

  Widget onListenerBuilder (
      Widget Function(HomeState state) builder,
  ) {
    return builder(this);
  }
}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
   List<BankAccount>? bankAccounts;
   Results? results;

  HomeLoadedState copyWith({
    List<BankAccount>? bankAccounts,
    Results? results,
  }) {
    return HomeLoadedState()
      ..bankAccounts = bankAccounts ?? this.bankAccounts
      ..results = results ?? this.results;
  }
}
