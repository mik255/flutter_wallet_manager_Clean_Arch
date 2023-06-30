import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../domain/models/bank_account.dart';
import '../../../../domain/models/transaction.dart';
import '../helper.dart';


class PlugglyService implements FinancialDataHelperService {
  String baseUrl = 'https://api.pluggy.ai';
  String apiKey = '';
  String accessToken = '';


  Set<String> cacheItems = {};
  Dio dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));
  @override
  Set<BankAccount> getBankAccounts = {};
  SharedPreferences? prefs;

  loadData() async {
    Platform.environment.forEach((key, value) {
      print('$key: $value');
    });
    const clientId = String.fromEnvironment('CLIENT_ID');
    const clientSecret = String.fromEnvironment('CLIENT_SECRET');
    prefs = await SharedPreferences.getInstance();
    cacheItems = prefs!.getStringList('items')?.toSet() ?? {};

    final apiKeyResponse = await dio.post('$baseUrl/auth',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {"clientId": clientId, "clientSecret": clientSecret});

    apiKey = apiKeyResponse.data['apiKey'];

    final accessTokenResponse = await dio.post(
      '$baseUrl/connect_token',
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "X-API-KEY": apiKey,
        },
      ),
    );

    accessToken = accessTokenResponse.data['accessToken'];

    var result = await Future.wait([
      ...cacheItems.map((e) =>  getAccount(e)),
    ]);
    getBankAccounts = result.toSet();
  }

  Future<List<Transaction>> getTransactions(String accountId) async {
    var response = await dio.get(
      '$baseUrl/transactions?accountId=$accountId',
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "X-API-KEY": apiKey,
        },
      ),
    );
    var data = response.data['results'] as List<dynamic>;
    return (data)
        .map((e) => Transaction(
              name: e['description'],
              date: e['date'],
              amount: e['amount'],
              installments: e['creditCardMetadata'] == null
                  ? '' // case true, transaction have no installments
                  : e['creditCardMetadata']['installmentNumber'] +
                      '/' +
                  e['creditCardMetadata']['totalInstallments'],
              bankName: '',
             type: TransactionType.values.firstWhere((element) => element.name == e['type'], orElse: () => TransactionType.DEBIT),
             category: TransactionCategory.values.firstWhere((element) => element.name == e['category'], orElse: () => TransactionCategory.OTHERS),
            ))
        .toList();
  }

  Future<BankAccount> getAccount(String itemId) async {
    var response = await dio.get(
      '$baseUrl/accounts?itemId=$itemId',
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "X-API-KEY": apiKey,
        },
      ),
    );
    var listBalances = await Future.wait(
        (response.data['results'] as List<dynamic>).map((e) async {
      var transactions = await getTransactions(e['id']);
      return BalanceType(
        id: e['id'] ?? 'null',
        name: e['name'] ?? 'null',
        balance: e['balance'],
        limit: e['creditData']?['creditLimit'],
        balanceType: BalanceTypeEnum.values.firstWhere((element) => element.name == e['subtype'], orElse: () => BalanceTypeEnum.CHECKING_ACCOUNT),
        logo: '',
        transactions: transactions,
      );
    }).toList());
    var account = BankAccount(
      balanceTypes: listBalances,
    );
    getBankAccounts.add(account);
    cacheItems.add(itemId);
    await prefs!.setStringList('items', cacheItems.toList());
    return account;
  }

  TransactionCategory getCategory(String category) {
    if (['Salary', 'Retirement', 'Entrepreneurial activities', 'Government aid', 'Non-recurring income'].contains(category)) {
      return TransactionCategory.INCOME;
    } else if (['Late payment and overdraft costs', 'Interests charged'].contains(category)) {
      return TransactionCategory.LOANS_AND_FINANCING;
    } else if (['Real estate financing', 'Vehicle financing', 'Student loan'].contains(category)) {
      return TransactionCategory.LOANS;
    } else if (['Automatic investment', 'Fixed income', 'Mutual funds', 'Variable income', 'Margin', 'Proceeds interests and dividends', 'Pension'].contains(category)) {
      return TransactionCategory.INVESTMENTS;
    } else if (['Same person transfer - Cash', 'Same person transfer - PIX', 'Same person transfer - TED'].contains(category)) {
      return TransactionCategory.SAME_PERSON_TRANSFER;
    } else if (['Transfer - Bank slip', 'Transfer - Cash', 'Transfer - Check', 'Transfer - DOC', 'Transfer - Foreign exchange', 'Transfer - Internal', 'Transfer - PIX', 'Transfer - TED'].contains(category)) {
      return TransactionCategory.TRANSFERS;
    } else if (['Credit card payment'].contains(category)) {
      return TransactionCategory.CREDIT_CARD_PAYMENT;
    } else if (['Blocked balances', 'Alimony'].contains(category)) {
      return TransactionCategory.LEGAL_OBLIGATIONS;
    } else if (['Telecommunications', 'Education', 'Wellness and fitness', 'Tickets'].contains(category)) {
      return TransactionCategory.SERVICES;
    } else if (['Internet', 'Mobile', 'TV'].contains(category)) {
      return TransactionCategory.TELECOMMUNICATIONS;
    } else if (['Online Courses', 'University', 'School', 'Kindergarten'].contains(category)) {
      return TransactionCategory.EDUCATION;
    } else if (['Gyms and fitness centers', 'Sports practice', 'Wellness'].contains(category)) {
      return TransactionCategory.WELLNESS_AND_FITNESS;
    } else if (['Stadiums and arenas', 'Landmarks and museums', 'Cinema, theater and concerts'].contains(category)) {
      return TransactionCategory.TICKETS;
    } else if (['Online shopping', 'Electronics', 'Pet supplies and vet', 'Clothing', 'Kids and toys', 'Bookstore', 'Sports goods', 'Office supplies', 'Cashback'].contains(category)) {
      return TransactionCategory.SHOPPING;
    } else if (['Gaming', 'Video streaming', 'Music streaming'].contains(category)) {
      return TransactionCategory.DIGITAL_SERVICES;
    } else if (['Eating out', 'Food delivery'].contains(category)) {
      return TransactionCategory.GROCERIES;
    } else if (['Airport and airlines', 'Accomodation', 'Mileage programs', 'Bus tickets'].contains(category)) {
      return TransactionCategory.TRAVEL;
    } else if (['Lottery', 'Online bet'].contains(category)) {
      return TransactionCategory.GAMBLING;
    } else if (['Income taxes', 'Taxes on investments', 'Tax on financial operations'].contains(category)) {
      return TransactionCategory.TAXES;
    } else if (['Account fees', 'Wire transfer fees and ATM fees', 'Credit card fees'].contains(category)) {
      return TransactionCategory.BANK_FEES;
    } else if (['Rent', 'Utilities', 'Houseware', 'Urban land and building tax'].contains(category)) {
      return TransactionCategory.HOUSING;
    } else if (['Water', 'Electricity', 'Gas'].contains(category)) {
      return TransactionCategory.UTILITIES;
    } else if (['Dentist', 'Pharmacy', 'Optometry', 'Hospital clinics and labs'].contains(category)) {
      return TransactionCategory.HEALTHCARE;
    } else if (['Taxi and ride-hailing', 'Public transportation', 'Car rental', 'Bycicle'].contains(category)) {
      return TransactionCategory.TRANSPORTATION;
    } else if (['Gas stations', 'Parking', 'Tolls and in vehicle payment', 'Vehicle ownership taxes and fees', 'Vehicle maintenance', 'Traffic tickets'].contains(category)) {
      return TransactionCategory.AUTOMOTIVE;
    } else if (['Life insurance', 'Home insurance', 'Health insurance', 'Vehicle insurance'].contains(category)) {
      return TransactionCategory.INSURANCE;
    } else if (['Leisure'].contains(category)) {
      return TransactionCategory.LEISURE;
    } else {
      return TransactionCategory.OTHERS;
    }
  }

}
