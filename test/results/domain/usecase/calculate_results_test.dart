import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_manager/app/modules/results/usecase/calculate_results.dart';
import 'package:wallet_manager/app/modules/results/usecase/filter_by_enter_or_out.dart';
import 'package:wallet_manager/app/modules/transactions/domain/models/transaction.dart';

void main() {
  group('calculo', () {
    test('testando cauculo dos meus resultados', () {
      CalculateResultsUserCase calculateResultsUserCase = CalculateResultsUserCase();
      var results = calculateResultsUserCase.call([
        Transaction(
          amount: 50,
          category: TransactionCategory(name: 'teste', icon: Icons.ac_unit),
          name: 'teste',
          date: 'teste',
          installments: '',
          bankName: '',
          type: TransactionType.CREDIT,
        ),
        Transaction(
          amount: 50,
          category: TransactionCategory(name: 'teste', icon: Icons.ac_unit),
          name: 'teste',
          date: 'teste',
          installments: '',
          bankName: '',
          type: TransactionType.CREDIT,
        ),
        Transaction(
            amount: 100,
            category: TransactionCategory(name: 'teste', icon: Icons.ac_unit),
            name: 'teste',
            date: 'teste',
            installments: '',
            bankName: '',
            type: TransactionType.DEBIT),
        Transaction(
          amount: 100,
          category: TransactionCategory(name: 'teste', icon: Icons.ac_unit),
          name: 'teste',
          date: 'teste',
          installments: '',
          bankName: '',
          type: TransactionType.DEBIT,
        ),
      ]);
      expect(results.totalValue, 300);
    });
    test('testando filtro de cauculo dos meus resultados', () {
      FilterCalculateResultsUserCase calculateResultsUserCase = FilterCalculateResultsUserCase();
      var results = calculateResultsUserCase.call(
        [
          Transaction(
            amount: 50,
            category: TransactionCategory(name: 'teste', icon: Icons.ac_unit),
            name: 'teste',
            date: 'teste',
            installments: '',
            bankName: '',
            type: TransactionType.CREDIT,
          ),
          Transaction(
            amount: 50,
            category: TransactionCategory(name: 'teste', icon: Icons.ac_unit),
            name: 'teste',
            date: 'teste',
            installments: '',
            bankName: '',
            type: TransactionType.CREDIT,
          ),
          Transaction(
              amount: 100,
              category: TransactionCategory(name: 'teste', icon: Icons.ac_unit),
              name: 'teste',
              date: 'teste',
              installments: '',
              bankName: '',
              type: TransactionType.DEBIT),
          Transaction(
            amount: 100,
            category: TransactionCategory(name: 'teste', icon: Icons.ac_unit),
            name: 'teste',
            date: 'teste',
            installments: '',
            bankName: '',
            type: TransactionType.DEBIT,
          ),
        ],
        true,
      );
      expect(results.totalValue, 100);
    });
  });

}
