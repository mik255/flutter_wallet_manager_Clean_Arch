import 'package:wallet_manager/app/modules/home/data/datasources/bank_datasource.dart';
import '../../../../../../../../core/data/http_client.dart';
import '../../../../../domain/models/bank_account.dart';
import '../../../../mappers/accountBank_mapper.dart';
import '../../../local_datasource.dart';

class PlugglyDatasource implements BankAccountDataSource {
  HttpClientApp httpClientApp;
  LocalDataSource localDataSource;

  PlugglyDatasource({
    required this.httpClientApp,
    required this.localDataSource,
  });

  late String _apikey;

  late String accessToken;
  Map<String, String>? _header;

  @override
  Future<void> init() async {
    await localDataSource.init();
    const clientId = String.fromEnvironment('CLIENT_ID') ?? '';
    const clientSecret = String.fromEnvironment('CLIENT_SECRET') ?? '';

    final String apiKeyResponse = await getApikey(
      clientId,
      clientSecret,
    );
    _apikey = apiKeyResponse;
    _header = {
      'Content-Type': 'application/json; charset=UTF-8',
      "X-API-KEY": _apikey,
    };
    final accessTokenResponse = await getAccessToken(
      _apikey,
    );
    accessToken = accessTokenResponse;
    await getBankAccountList();
  }

  Future<String> getApikey(String clientId, String clientSecret) async {

    var result = await httpClientApp.post('https://api.pluggy.ai/auth', {
      "clientId": clientId,
      "clientSecret": clientSecret,
    },headers:{} );
    return result.data['apiKey'];
  }

  Future<String> getAccessToken(String apikey) async {
    var result = await httpClientApp
        .post('https://api.pluggy.ai/connect_token', {}, headers: {
      "X-API-KEY": apikey,
    });

    return result.data['accessToken'];
  }

  Future<Map<String, dynamic>> getItems() async {
    var result = await httpClientApp.get( 'https://api.pluggy.ai/items',);
    return result.data;
  }

  Future<Map<String, dynamic>> getAccounts(String id) async {
    var result = await httpClientApp.get('https://api.pluggy.ai/accounts/$id',);
    return result.data;
  }

  Future<Map<String, dynamic>> getTransactions(String id) async {
    var result = await httpClientApp.get('https://api.pluggy.ai/transactions/$id',);
    return result.data;
  }

  @override
  Future<BankAccount> getBankAccount(String id) async {
    var item = await getItems();
    var balanceTypes = await getAccounts(id);
    var transactions = await getTransactions(id);

    return BankAccountDto().plugglyServiceToEntity(
      item,
      balanceTypes,
      transactions,
    );
  }

  @override
  Future<List<BankAccount>> getBankAccountList() async {
    var cache = await localDataSource.getList('accounts');
    var result = await Future.wait(cache.map((e) => getBankAccount(e)));
    return result;
  }

  @override
  Future<void> saveBankAccount(
    BankAccount bankAccount,
  ) async {
    var result = await localDataSource.getList('accounts');
    result.add(bankAccount.id);
    await localDataSource.saveList('accounts', result);
  }
}
