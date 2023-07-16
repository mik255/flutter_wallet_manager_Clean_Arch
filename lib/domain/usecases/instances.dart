import 'package:wallet_manager/domain/models/transaction.dart';
import '../models/bank_account.dart';
import '../models/user.dart';

List<BankAccount> currentBankAccounts = [];
List<Transaction> currentBankTransactionsFiltered = [];
User currentUser = User(
  name: '',
  email: '',
  password: '',
);
