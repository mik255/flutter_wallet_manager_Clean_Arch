import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wallet_manager/app/modules/account/view/login_page.dart';
import 'package:wallet_manager/app/modules/home/domain/repositories/bank_repository.dart';
import 'package:wallet_manager/app/modules/home/presenter/pages/home_page.dart';
import 'app/modules/account/data/repositories/auth/auth_impl.dart';
import 'app/modules/account/domain/interactors/auth_view_model/auth_view_model.dart';
import 'app/modules/account/infra/datasources/auth/google_login_impl.dart';
import 'app/modules/account/states/auth_with_velueNotifie.dart';
import 'app/modules/home/data/datasources/local/bankAccountLocalDataSource.dart';
import 'app/core/driver/shared_preferences_impl.dart';
import 'app/modules/home/data/repository/local_storange_bank_repo_impl.dart';
import 'app/modules/home/domain/usecase/bank_account/get_banks_account.dart';
import 'app/modules/transactions/data/datasources/local/transactions_local_datasource_impl.dart';
import 'app/modules/transactions/data/repository/transactions_repository_impl.dart';
import 'app/modules/transactions/domain/usecases/get_transactions_usecase.dart';
import 'main_stances.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainStances.init();
  getIt.registerLazySingleton<SharedPreferencesImpl>(() => SharedPreferencesImpl());
  await GetIt.I<SharedPreferencesImpl>().init();
  getIt.registerLazySingleton<BankAccountLocalDataSource>(() => BankAccountLocalDataSource(
        localDataSource: GetIt.I<SharedPreferencesImpl>(),
      ));

  getIt.registerLazySingleton<BankAccountRepository>(() => BankAccountRepositoryImpl(
        bankAccountDataSource: GetIt.I<BankAccountLocalDataSource>(),
      ));
  getIt.registerLazySingleton<GetBankAccountListViewModelUseCase>(
      () => GetBankAccountListViewModelUseCase(
            GetIt.I<BankAccountRepository>(),
          ));

  // Inicialize o GetIt
  getIt.registerLazySingleton<GoogleLoginServiceImpl>(() => GoogleLoginServiceImpl());
  getIt.registerLazySingleton<AuthImpl>(() => AuthImpl(
        authDataSource: GetIt.instance<GoogleLoginServiceImpl>(),
      ));
  getIt.registerLazySingleton<AuthStateImpl>(() => AuthStateImpl());
  getIt.registerLazySingleton<AuthViewModel>(() => AuthViewModel(
        repository: GetIt.instance<AuthImpl>(),
        state: GetIt.instance<AuthStateImpl>(),
      ));
  //LocalTransactionDataSourceImpl
  getIt.registerLazySingleton(
      () => LocalTransactionDataSourceImpl(GetIt.I<SharedPreferencesImpl>()));
  //TransactionRepositoryImpl
  getIt.registerLazySingleton(() =>
      TransactionRepositoryImpl(LocalTransactionDataSourceImpl(GetIt.I<SharedPreferencesImpl>())));
  //GetTransactionsUseCase
  getIt.registerLazySingleton(() => GetTransactionsUseCase(GetIt.I<TransactionRepositoryImpl>()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            primary: Colors.blue,
            secondary: Colors.white,
            seedColor: Colors.blue,
          ),
          useMaterial3: true,
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
        initialRoute: '/login');
  }
}
