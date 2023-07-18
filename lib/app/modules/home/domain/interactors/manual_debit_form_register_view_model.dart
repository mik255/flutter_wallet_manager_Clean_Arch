


import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../repositories/bank_repository.dart';

class ManualDebtFormRegisterViewModel {
  ManualDebtFormRegisterViewModel({
    required this.bankAccountRepository,
  });

  final BankAccountRepository bankAccountRepository;
  Transaction transaction = Transaction(
    type: TransactionType.DEBIT,
    category: TransactionCategory(
      category: '',
      icon: Icons.ac_unit,
    ),
    name: '',
    amount: 0,
    installments: '',
    bankName: '',
    date: '',
  );
  categoriesList() {
    return [
      'Alimentação',
      'Educação',
      'Lazer',
      'Moradia',
      'Saúde',
      'Transporte',
      'Vestuário',
      'Outros',
    ];
  }

  financeInstitutionsList() {
    return [
      'Banco do Brasil',
      'Bradesco',
      'Caixa Econômica Federal',
      'Itaú',
      'Nubank',
      'Santander',
      'Outros',
    ];
  }

  bool onSave(BuildContext context, GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar')),
      );
      return false;
    }

    return true;
  }

}