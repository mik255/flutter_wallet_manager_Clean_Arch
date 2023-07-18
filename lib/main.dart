import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/home/view_models/home_load_data.dart';
import 'package:wallet_manager/domain/repositories/bank_repository.dart';
import 'package:wallet_manager/infra/repository/remote/google_login_impl.dart';
import 'app/home/view_models/manual_debit_form_register_view_model.dart';
import 'app/login/login_build.dart';
import 'app/shared/view_models/user_viewmodel.dart';
import 'infra/repository/local/local_storange_bank_repo_impl.dart';
import 'infra/repository/local/shared_preferences_impl.dart';
import 'main_stances.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainStances.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BankAccountRepository bankAccountRepository;

  @override
  void initState() {
    bankAccountRepository = LocalBankAccountRepositoryImpl(
      localStorageInterface: SharedPreferencesImpl()..init(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthViewModel>(
          create: (_) => AuthViewModel(
            authRepository: GoogleLoginServiceImpl(),
          ),
        ),
        Provider<HomeViewModel>(
          create: (_) => HomeViewModel(
            bankAccountRepository: bankAccountRepository,
          ),
        ),
        Provider<ManualDebtFormRegisterViewModel>(
          create: (_) => ManualDebtFormRegisterViewModel(
            bankAccountRepository: bankAccountRepository,
          ),
        ),
      ],
      child: MaterialApp(
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
        home: const LoginBuild(),
      ),
    );
  }
}
