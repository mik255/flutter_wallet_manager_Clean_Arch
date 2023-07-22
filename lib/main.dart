import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wallet_manager/app/modules/account/view/login_page.dart';
import 'package:wallet_manager/app/modules/home/presenter/pages/home_page.dart';
import 'app/modules/account/data/repositories/auth/auth_impl.dart';
import 'app/modules/account/domain/interactors/auth_view_model/auth_view_model.dart';
import 'app/modules/account/infra/datasources/auth/google_login_impl.dart';
import 'app/modules/account/states/auth_with_velueNotifie.dart';
import 'app/modules/home/data/datasources/local/bankAccountLocalDataSource.dart';
import 'app/modules/home/data/datasources/local/shared_preferences_impl.dart';
import 'app/modules/home/data/repository/local_storange_bank_repo_impl.dart';
import 'app/modules/home/domain/interactors/home_view_model_impl.dart';
import 'app/modules/home/presenter/state/valueNotifie_impl.dart';
import 'app/shared/navigator/route_impl.dart';
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
  getIt.registerLazySingleton<BankAccountRepositoryImpl>(() => BankAccountRepositoryImpl(
    bankAccountDataSource: GetIt.I<BankAccountLocalDataSource>(),
  ));
  getIt.registerLazySingleton<HomeBindImpl>(() => HomeBindImpl());
  getIt.registerLazySingleton<HomeViewModelImpl>(() => HomeViewModelImpl(
    bankAccountRepository: GetIt.I<BankAccountRepositoryImpl>(),
    bind: GetIt.instance<HomeBindImpl>(),
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
      initialRoute: '/login'
    );
  }
}
