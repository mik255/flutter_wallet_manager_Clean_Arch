import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  var dataRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime.now(),
  );

  ValueNotifier<bool> loadingUpdating = ValueNotifier<bool>(false);

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

    await getAllAccounts();
  }

  Future<void> getAllAccounts() async {
    getBankAccounts = {};
    cacheItems = {};
    List<String> items = prefs!.getStringList('items')?.toList() ?? [];
    var result = await Future.wait([
      ...items.map((e) => getAccount(e)),
    ]);
    await prefs!.setStringList('items', cacheItems.toList());
    getBankAccounts = result.toSet();
  }

  Future<void> updateTransactionsByRange(DateTimeRange dateTimeRange, int page,
      {int limit = 500}) async {
    dataRange = dateTimeRange;
    List<BalanceType> balanceTypes =
        getBankAccounts.expand((element) => element.balanceTypes).toList();
    for (var element in balanceTypes) {
      element.transactions = [];
    }
    await Future.wait(balanceTypes.map((e) => _getTransactions(
          e,
          range: dataRange,
          page: page,
          limit: limit,
        )));
  }

  Future<List<Transaction>> _getTransactions(BalanceType balanceType,
      {DateTimeRange? range, int page = 1, int limit = 500}) async {
    dataRange = range ?? dataRange;
    List<Transaction> transactions = [];
    int length = -1;
    while (length < transactions.length) {
      length = transactions.length;
      var response = await dio.get(
        '$baseUrl/transactions?accountId=${balanceType.id}',
        queryParameters: range == null
            ? null
            : {
                'from': range.start.toIso8601String(),
                'to': range.end.toIso8601String(),
                'page': page,
                'pageSize': limit
              },
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "X-API-KEY": apiKey,
          },
        ),
      );
      var data = response.data['results'] as List<dynamic>;
      transactions.addAll(balanceType.transactions = (data)
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
                type: TransactionType.values.firstWhere(
                    (element) => element.name == e['type'],
                    orElse: () => TransactionType.DEBIT),
                category: getCategory(e['category']),
              ))
          .toList());
      page++;
    }
    print('transactions: ${transactions.length}');
    return balanceType.transactions = transactions;
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
    var list = response.data['results'] as List<dynamic>;

    var listBalances = await Future.wait(list.map((e) async {
      var balanceType = BalanceType(
        balanceCloseDate: e['creditData']?['balanceCloseDate'],
        balanceDueDate: e['creditData']?['balanceDueDate'],
        id: e['id'] ?? 'null',
        name: e['name'] ?? 'null',
        balance: e['balance'],
        limit: e['creditData']?['creditLimit'],
        availableLimit: e['creditData']?['availableCreditLimit'],
        balanceType: BalanceTypeEnum.values.firstWhere(
            (element) => element.name == e['subtype'],
            orElse: () => BalanceTypeEnum.CHECKING_ACCOUNT),
        logo: '',
        transactions: [],
      );
      await _getTransactions(balanceType, page: 1, range: dataRange);
      cacheItems.add(itemId);
      return balanceType;
    }).toList());
    var account = BankAccount(
      balanceTypes: listBalances,
    );
    getBankAccounts.add(account);
    return account;
  }

  TransactionCategory getCategory(String? category) {

    if ([
      'Salary',
      'Retirement',
      'Entrepreneurial activities',
      'Government aid',
      'Non-recurring income'
    ].contains(category)) {
      return TransactionCategory.INCOME;
    } else if (['Late payment and overdraft costs', 'Interests charged']
        .contains(category)) {
      return TransactionCategory.LOANS_AND_FINANCING;
    } else if (['Real estate financing', 'Vehicle financing', 'Student loan']
        .contains(category)) {
      return TransactionCategory.LOANS;
    } else if ([
      'Automatic investment',
      'Fixed income',
      'Mutual funds',
      'Variable income',
      'Margin',
      'Proceeds interests and dividends',
      'Pension'
    ].contains(category)) {
      return TransactionCategory.INVESTMENTS;
    } else if ([
      'Same person transfer - Cash',
      'Same person transfer - PIX',
      'Same person transfer - TED'
    ].contains(category)) {
      return TransactionCategory.SAME_PERSON_TRANSFER;
    } else if ([
      'Transfer - Bank slip',
      'Transfer - Cash',
      'Transfer - Check',
      'Transfer - DOC',
      'Transfer - Foreign exchange',
      'Transfer - Internal',
      'Transfer - PIX',
      'Transfer - TED',
      'Transfers',
      'Same person transfer'
    ].contains(category)) {
      return TransactionCategory.TRANSFERS;
    } else if (['Credit card payment' ]
        .contains(category)) {
      return TransactionCategory.CREDIT_CARD_PAYMENT;
    } else if (['Blocked balances', 'Alimony'].contains(category)) {
      return TransactionCategory.LEGAL_OBLIGATIONS;
    } else if ([
      'Telecommunications',
      'Education',
      'Wellness and fitness',
      'Tickets',
      'Internet', 'Mobile', 'TV'
    ].contains(category)) {
      return TransactionCategory.SERVICES;
    } else if (['Internet', 'Mobile', 'TV'].contains(category)) {
      return TransactionCategory.TELECOMMUNICATIONS;
    } else if (['Online Courses', 'University', 'School', 'Kindergarten']
        .contains(category)) {
      return TransactionCategory.EDUCATION;
    } else if (['Gyms and fitness centers', 'Sports practice', 'Wellness']
        .contains(category)) {
      return TransactionCategory.WELLNESS_AND_FITNESS;
    } else if ([
      'Stadiums and arenas',
      'Landmarks and museums',
      'Cinema, theater and concerts'
    ].contains(category)) {
      return TransactionCategory.TICKETS;
    } else if ([
      'Online shopping',
      'Electronics',
      'Pet supplies and vet',
      'Clothing',
      'Kids and toys',
      'Bookstore',
      'Sports goods',
      'Office supplies',
      'Cashback'
    ].contains(category)) {
      return TransactionCategory.SHOPPING;
    } else if (['Gaming', 'Video streaming', 'Music streaming', 'Shopping']
        .contains(category)) {
      return TransactionCategory.FOOD_AND_DRINKS;
    } else if (['Eating out', 'Food delivery'].contains(category)) {
      return TransactionCategory.GROCERIES;
    } else if ([
      'Airport and airlines',
      'Accomodation',
      'Mileage programs',
      'Bus tickets'
    ].contains(category)) {
      return TransactionCategory.TRAVEL;
    } else if (['Lottery', 'Online bet'].contains(category)) {
      return TransactionCategory.GAMBLING;
    } else if ([
      'Income taxes',
      'Taxes on investments',
      'Tax on financial operations'
    ].contains(category)) {
      return TransactionCategory.TAXES;
    } else if ([
      'Account fees',
      'Wire transfer fees and ATM fees',
      'Credit card fees'
    ].contains(category)) {
      return TransactionCategory.BANK_FEES;
    } else if (['Rent', 'Utilities', 'Houseware', 'Urban land and building tax']
        .contains(category)) {
      return TransactionCategory.HOUSING;
    } else if (['Water', 'Electricity', 'Gas'].contains(category)) {
      return TransactionCategory.UTILITIES;
    } else if (['Dentist', 'Pharmacy', 'Optometry', 'Hospital clinics and labs']
        .contains(category)) {
      return TransactionCategory.HEALTHCARE;
    } else if ([
      'Taxi and ride-hailing',
      'Public transportation',
      'Car rental',
      'Bycicle'
    ].contains(category)) {
      return TransactionCategory.TRANSPORTATION;
    } else if ([
      'Gas stations',
      'Parking',
      'Tolls and in vehicle payment',
      'Vehicle ownership taxes and fees',
      'Vehicle maintenance',
      'Traffic tickets'
    ].contains(category)) {
      return TransactionCategory.AUTOMOTIVE;
    } else if ([
      'Life insurance',
      'Home insurance',
      'Health insurance',
      'Vehicle insurance'
    ].contains(category)) {
      return TransactionCategory.INSURANCE;
    } else if (['Leisure'].contains(category)) {
      return TransactionCategory.LEISURE;
    } else {
      return TransactionCategory.OTHERS;
    }
  }

  Future<void> updateAllItem() async {
    loadingUpdating.value=true;
    List<String> sendRequestAndGetUpdateItemsId = await Future.wait(cacheItems.map((e) async {
      return updateItem(e);
    }).toList());
    List<String> itemsId = sendRequestAndGetUpdateItemsId;
    var response = await Future.wait(
      itemsId.map((e) async {
        return updatingItemById(e);
      }).toList(),
    );
    await prefs!.setStringList(
        'items', response.map((e) => e.data['id'] as String).toList());
    await getAllAccounts();
    loadingUpdating.value=false;
  }

  Future<Response> updatingItemById(String itemId) async {
    var response = await dio.get(
      '$baseUrl/items/$itemId',
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "X-API-KEY": apiKey,
        },
      ),
    );
    //semaforo para esperar a atualização do item
    if (response.data['status'] == 'UPDATING') {
      await Future.delayed(const Duration(seconds: 2));
      await updatingItemById(itemId);
    }
    return response;
  }

  Future<String> updateItem(String itemId) async {
    var response = await dio.patch(
      '$baseUrl/items/$itemId',
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "X-API-KEY": apiKey,
        },
      ),
    );

    return response.data['id'];
  }
}
