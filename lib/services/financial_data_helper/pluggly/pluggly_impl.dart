import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_manager/models/transaction.dart';
import 'package:wallet_manager/services/financial_data_helper/helper.dart';
import '../../../models/bank_account.dart';

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
}
