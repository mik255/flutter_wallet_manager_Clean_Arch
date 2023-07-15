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

  @override
  loadData() async {
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

  @override
  Future<void> getAllAccounts() async {
    getBankAccounts = {};
    cacheItems = {};
    List<String> items = prefs!.getStringList('items')?.toList() ?? [];
    var result = await Future.wait([
      ...items.map((e) => getAccount(e)),
    ]);
    cacheItems = items.toSet();
    await prefs!.setStringList('items', cacheItems.toList());
    getBankAccounts = result.toSet();
  }

  @override
  Future<void> updateTransactionsByRange(DateTimeRange dateTimeRange, int page,
      {int limit = 500}) async {
    dataRange = dateTimeRange;
    List<BalanceType> balanceTypes =
        getBankAccounts.expand((element) => element.balanceTypes).toList();
    for (var element in balanceTypes) {
      element.transactions = [];
    }
    await Future.wait(balanceTypes.map((e) => getTransactions(
          e,
          range: dataRange,
          page: page,
          limit: limit,
        )));
  }

  @override
  Future<List<Transaction>> getTransactions(BalanceType balanceType,
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
    return balanceType.transactions = transactions;
  }

  @override
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
                        String owner = list[0]['owner'];    
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
      await getTransactions(balanceType, page: 1, range: dataRange);
      cacheItems.add(itemId);
      return balanceType;
    }).toList());
    var result = await dio.get(
      '$baseUrl/items/$itemId',
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "X-API-KEY": apiKey,
        },
      ),
    );
    var account = BankAccount(
      owner: owner,
      logo: result.data['connector']['imageUrl'],
      name: result.data['connector']['name'],
      balanceTypes: listBalances,
    );
    getBankAccounts.add(account);
    return account;
  }

  @override
  Future<void> updateAllItem() async {
    loadingUpdating.value=true;
    try {
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
    } catch (e,_) {
      print(e);
      print(_);
    }
    loadingUpdating.value=false;
  }

  @override
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

  @override
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
