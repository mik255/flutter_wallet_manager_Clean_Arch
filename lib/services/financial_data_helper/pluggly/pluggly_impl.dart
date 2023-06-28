import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_manager/models/transaction.dart';
import 'package:wallet_manager/services/financial_data_helper/helper.dart';
import '../../../models/bank_account.dart';

class PlugglyService implements FinancialDataHelperService {
  String baseUrl = 'https://api.pluggy.ai';
  String apiKey = '';
  String accessToken = '';
  String clientId = '44ffcfd5-4714-4d01-a789-752a757fee90';
  String clientSecret = 'b4d15664-5957-4a9e-9b3f-c121cdf78472';

  Set<String> cacheAccounts = {};
  Dio dio = Dio();
  @override
  Set<BankAccount> getBankAccounts = {};
  SharedPreferences? prefs;

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    cacheAccounts = prefs!.getStringList('accounts')?.toSet() ?? {};
    getBankAccounts =
        cacheAccounts.map((e) => BankAccount.fromJson(jsonDecode(e))).toSet();

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
    return (response.data['results'] as List<dynamic>)
        .map((e) => Transaction(
              name: response.data['description'],
              date: response.data['date'],
              amount: response.data['amount'],
              installments: response.data['creditCardMetadata'] == null
                  ? '' // case true, transaction have no installments
                  : response.data['creditCardMetadata']['installmentNumber'] +
                      '/' +
                      response.data['creditCardMetadata']['totalInstallments'],
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
        id: e['id'],
        name: e['name'],
        balance: e['balance'],
        balanceType: BalanceTypeEnum.values[e['subtype']],
        logo: '',
        transactions: transactions,
      );
    }).toList());
    var account = BankAccount(
      accountId: response.data['id'],
      name: response.data['name'],
      balanceTypes: listBalances,
    );
    getBankAccounts.add(account);
    cacheAccounts.add(account.toJson().toString());
    await prefs!.setStringList('accounts', cacheAccounts.toList());
    return account;
  }
}
