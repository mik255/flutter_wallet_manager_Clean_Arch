
import '../../models/bank_account.dart';

abstract class FinancialDataHelperService{
  late Set<BankAccount> getBankAccounts;
}