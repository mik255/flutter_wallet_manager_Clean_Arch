import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_manager/app/modules/home/data/datasources/local/bankAccountLocalDataSource.dart';
import 'package:wallet_manager/app/core/driver/shared_preferences_impl.dart';
import 'package:wallet_manager/app/modules/home/domain/models/balance_type.dart';
import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';
import 'package:wallet_manager/app/modules/transactions/domain/models/transaction.dart';

void main() {
  test('', () async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    BankAccountLocalDataSource bankAccountLocalDataSource = BankAccountLocalDataSource(
      localDataSource: SharedPreferencesImpl(),
    );

    await bankAccountLocalDataSource.init();
    await bankAccountLocalDataSource.saveBankAccount(
      BankAccount(
        id: '1',
        name: 'teste',
        balanceTypes: [
          BalanceType(
            id: '1',
            name: 'teste',
            balance: 1,
            balanceType: BalanceTypeEnum.CHECKING_ACCOUNT,
            logo: '',
            transactions: [
              Transaction(
                  category: TransactionCategory(
                    name: '',
                    icon: Icons.ac_unit,
                  ),
                  name: 'name',
                  date: 'date',
                  amount: 10.0,
                  installments: 'installments',
                  bankName: 'bankName',
                  type: TransactionType.CREDIT)
            ],
            limit: 1,
            availableLimit: 1,
            balanceCloseDate: '',
            balanceDueDate: '',
          ),
        ],
        owner: '',
        logo: '',
      ),
    );
    var bank = await bankAccountLocalDataSource.getBankAccount('1');
    expect(bank, isNotNull);
  });
}
