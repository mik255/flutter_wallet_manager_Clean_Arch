import '../models/bank_account.dart';

abstract class HomeLoadDataViewModel {
  loadInitialData();
  late bool loadingState;
  late List<BankAccount> bankAccounts;
}
