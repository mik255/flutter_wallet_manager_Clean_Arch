import 'package:wallet_manager/domain/models/bank_account.dart';
import 'package:wallet_manager/domain/models/transaction.dart';

class FinancialResultsCalculator {
  num inputsBalance = 0;
  num outputsBalance = 0;
  num balance = 0;
  num savingsBalance = 0;
  num creditCardBalance = 0;
  List<Map<TransactionCategory, double>> percentageByCategories = [];
  List<BankAccount> allBanks;

  FinancialResultsCalculator({required this.allBanks}) {
    calculate();
  }

  calculate() {
    percentageByCategories =
        TransactionCategory.values.map((e) => {e: 0.0}).toList(growable: false);

    for (var element in allBanks) {
      element.balanceTypes.map((e) => e.transactions).forEach((element) {
        for (var transaction in element) {
          if (transaction.amount > 0 &&
              transaction.type == TransactionType.CREDIT) {
            inputsBalance += transaction.amount;
          } else {
            outputsBalance += transaction.amount;
          }
          percentageByCategories
              .firstWhere((e) => e.keys.first == transaction.category)
              .update(transaction.category,
                  (value) => value + transaction.amount.abs());
        }
      });
      savingsBalance += element.balanceTypes
          .firstWhere((e) => e.balanceType == BalanceTypeEnum.SAVINGS_ACCOUNT,
              orElse: () => BalanceType(
                    id: '',
                    name: '',
                    balance: 0,
                    balanceType: BalanceTypeEnum.SAVINGS_ACCOUNT,
                    logo: '',
                    transactions: [],
                    limit: null,
                  ))
          .balance;
      balance += element.balanceTypes
          .firstWhere((e) => e.balanceType == BalanceTypeEnum.CHECKING_ACCOUNT,
              orElse: () => BalanceType(
                    id: '',
                    name: '',
                    balance: 0,
                    balanceType: BalanceTypeEnum.CHECKING_ACCOUNT,
                    logo: '',
                    transactions: [],
                    limit: null,
                  ))
          .balance;
      var credit = element.balanceTypes
          .firstWhere((e) => e.balanceType == BalanceTypeEnum.CREDIT_CARD,
              orElse: () => BalanceType(
                    id: '',
                    name: '',
                    balance: 0,
                    balanceType: BalanceTypeEnum.CREDIT_CARD,
                    logo: '',
                    transactions: [],
                    limit: null,
                  ));
      creditCardBalance += (credit.limit??0) - credit.balance;
    }
  }
}
