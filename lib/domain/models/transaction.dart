import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transaction {
  String name;
  String date;
  num amount;
  String installments;
  String bankName;
  TransactionCategory category;
  TransactionType type;

  Transaction({
    required this.category,
    required this.name,
    required this.date,
    required this.amount,
    required this.installments,
    required this.bankName,
    required this.type,
  });


}

enum TransactionType {
  CREDIT,
  DEBIT,
}

class TransactionCategory {
  String category;
  IconData icon;

  TransactionCategory({
    required this.category,
    required this.icon,
  });
}

TransactionCategory getCategory(String? category) {
  if ([
    'Income',
    'Salary',
    'Retirement',
    'Entrepreneurial activities',
    'Government aid',
    'Non-recurring income'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Renda', icon: Icons.arrow_downward_outlined);
  } else if (['Loans and financing','Late payment and overdraft costs', 'Financing', 'Loans','Real estate financing', 'Vehicle financing', 'Student loan']
      .contains(category)) {
    return TransactionCategory(
        category: 'Empréstimos e financiamentos', icon: Icons.money_rounded);
  } else if ([
    'Investments',
    'Automatic investment',
    'Fixed income',
    'Mutual funds',
    'Variable income',
    'Margin',
    'Proceeds interests and dividends',
    'Pension'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Investimentos', icon: Icons.add_chart);
  } else if ([
    'Transfer - Internal',
  ].contains(category)) {
    return TransactionCategory(
        category: 'Movimentações internas', icon: Icons.compare_arrows);
  } else if ([
    'Transfer - Bank slip',
    'Transfer - Cash',
    'Transfer - Check',
    'Transfer - DOC',
    'Transfer - Foreign exchange',
    'Transfer - PIX',
    'Transfer - TED',
    'Transfers',
  ].contains(category)) {
    return TransactionCategory(
        category: 'Transferência', icon: Icons.cached);
  } else if (['Same person transfer']
      .contains(category)) {
    return TransactionCategory(
        category: 'Movimentação de Saldo', icon: Icons.person);
  }
  else if (['Credit card payment' ]
      .contains(category)) {
    return TransactionCategory(
        category: 'Pagamento de Cartão de Crédito', icon: Icons.credit_card_outlined);
  } else if (['Blocked balances', 'Alimony','Legal obligations'].contains(category)) {
    return TransactionCategory(
        category: 'Obrigações legais', icon: Icons.gavel_rounded);
  } else if ([
    'Services',
    'Telecommunications',
    'Education',
    'Wellness and fitness',
    'Tickets',
    'Internet', 'Mobile', 'TV'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Serviços', icon: Icons.computer);
  } else if (['Online Courses', 'University', 'School', 'Kindergarten','Shopping']
      .contains(category)) {
    return TransactionCategory(
        category: 'Educação', icon: Icons.school);
  } else if (['Gyms and fitness centers', 'Sports practice', 'Wellness']
      .contains(category)) {
    return TransactionCategory(
        category: 'Fitness', icon: Icons.fitness_center);
  } else if ([
    'Stadiums and arenas',
    'Landmarks and museums',
    'Cinema, theater and concerts'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Fitness', icon: Icons.stadium);
  } else if ([
    'Online shopping',
    'Electronics',
    'Pet supplies and vet',
    'Clothing',
    'Kids and toys',
    'Bookstore',
    'Sports goods',
    'Office supplies',
    'Cashback',
    'Shopping'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Compras', icon: Icons.stadium);
  } else if (['Gaming',]
      .contains(category)) {
    return TransactionCategory(
        category: 'Games', icon: Icons.sports_esports);
  } else if (['Video streaming',]
      .contains(category)) {
    return TransactionCategory(
        category: 'Video streaming', icon: Icons.ondemand_video);
  }
  else if (['Digital services',]
      .contains(category)) {
    return TransactionCategory(
        category: 'Serviços Digitais', icon: Icons.computer);
  }
  else if (['Music streaming',]
      .contains(category)) {
    return TransactionCategory(
        category: 'Música', icon: Icons.music_note);
  }
  else if (['Eating out', 'Food delivery','Food and drinks'].contains(category)) {
    return TransactionCategory(
        category: 'Alimentação', icon: Icons.restaurant);
  } else if ([
    'Travel',
    'Airport and airlines',
    'Accomodation',
    'Mileage programs',
    'Bus tickets'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Viagens', icon: Icons.location_on);
  } else if (['Lottery', 'Online bet'].contains(category)) {
    return TransactionCategory(
        category: 'Loterias e Apostas', icon: Icons.attach_money_sharp);
  } else if ([
    'Income taxes',
    'Taxes on investments',
    'Tax on financial operations'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Taxas', icon: Icons.corporate_fare);
  } else if ([
    'Account fees',
    'Wire transfer fees and ATM fees',
    'Credit card fees',
    'Bank fees'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Taxas Bancárias', icon: Icons.account_balance_rounded);
  } else if (['Rent', 'Utilities', 'Houseware', 'Urban land and building tax']
      .contains(category)) {
    return TransactionCategory(
        category: 'Utilitários', icon: Icons.home_repair_service_rounded);
  } else if (['Water', 'Electricity', 'Gas','Housing'].contains(category)) {
    return TransactionCategory(
        category: 'Casa', icon: Icons.house);
  } else if (['Dentist', 'Pharmacy', 'Optometry', 'Hospital clinics and labs','Healthcare']
      .contains(category)) {
    return TransactionCategory(
        category: 'Saúde', icon: Icons.health_and_safety);
  } else if ([
    'Taxi and ride-hailing',
    'Public transportation',
    'Car rental',
    'Bycicle',
    'Transportation'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Transporte', icon: Icons.directions_bus);
  } else if ([
    'Gas stations',
    'Parking',
    'Tolls and in vehicle payment',
    'Vehicle ownership taxes and fees',
    'Vehicle maintenance',
    'Traffic tickets'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Automotivo', icon: Icons.car_crash);
  } else if ([
    'Life insurance',
    'Home insurance',
    'Health insurance',
    'Vehicle insurance'
  ].contains(category)) {
    return TransactionCategory(
        category: 'Seguros', icon: Icons.health_and_safety);
  } else if (['Leisure'].contains(category)) {
    return TransactionCategory(
        category: 'Lazer', icon: Icons.surfing);
  } else {
    return TransactionCategory(
        category: category??'outros', icon: Icons.dynamic_feed);
  }
}
