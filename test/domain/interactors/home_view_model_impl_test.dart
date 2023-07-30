import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_manager/app/core/driver/shared_preferences_impl.dart';
import 'package:wallet_manager/app/modules/home/data/datasources/remote/open_finance_service%20/pluggly/pluggly_mock.dart';
import 'package:wallet_manager/app/modules/home/data/datasources/remote/open_finance_service%20/pluggly/pluggly_service_datasource.dart';
import 'package:wallet_manager/app/modules/home/data/repository/local_storange_bank_repo_impl.dart';
import 'package:wallet_manager/app/modules/home/domain/state/home_view_model.dart';
import 'package:wallet_manager/app/modules/home/presenter/state/valueNotifie_impl.dart';
import 'package:wallet_manager/core/data/http_client.dart';

class AppHttpMock extends Mock implements HttpClientApp {}

main() {
  test('should be get account correctly', () async {
    SharedPreferences.setMockInitialValues({
      'accounts': ['123']
    });
    //mock
    HttpClientApp httpClientApp = AppHttpMock();
    SharedPreferencesImpl sharedPreferencesImpl = SharedPreferencesImpl();
    var plugglyDatasource = PlugglyDatasource(
      httpClientApp: httpClientApp,
      localDataSource: sharedPreferencesImpl,
    );
    //arrange
    final viewModel = HomeViewModelImpl(
      bankAccountRepository: BankAccountRepositoryImpl(
        bankAccountDataSource: plugglyDatasource,
      ),
      bind: HomeBindImpl(),
    );
    when(() =>
            httpClientApp.post('https://api.pluggy.ai/auth', any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => AppHttpResponse(statusCode: 200, data: {"apiKey": "apiKey"}));
    when(() => httpClientApp.post('https://api.pluggy.ai/connect_token', any(),
            headers: any(named: 'headers')))
        .thenAnswer(
            (_) async => AppHttpResponse(statusCode: 200, data: {"accessToken": "accessToken"}));
    when(() => httpClientApp.get(
          'https://api.pluggy.ai/items',
        )).thenAnswer((_) async => AppHttpResponse(statusCode: 200, data: mock_itemid));
    when(() => httpClientApp.get(
          'https://api.pluggy.ai/accounts/123',
        )).thenAnswer((_) async => AppHttpResponse(statusCode: 200, data: mock_account));
    when(() => httpClientApp.get(
          'https://api.pluggy.ai/transactions/123',
        )).thenAnswer((_) async => AppHttpResponse(statusCode: 200, data: mock_transactions));
    // act
    await viewModel.loadInitialData();
    // assert
    expect(viewModel.bind.state, isA<HomeLoadedState>());
    var result = viewModel.bind.state as HomeLoadedState;
    expect(result.bankAccounts!.isNotEmpty, true);
  });
}
