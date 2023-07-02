import 'package:flutter/material.dart';
import 'package:wallet_manager/app/view_models/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'app/login/login_build.dart';
import 'infra/preferences_helper.dart';
import 'main_stances.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MainStances.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Aqui você pode adicionar todos os provedores que deseja fornecer
        Provider<UserViewModel>(
          create: (_) => UserViewModel(
            helper: SharedPreferencesHelper(
              MainStances.preferences,
            )
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
              seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home:  const LoginBuild(),
      ),
    );
  }
}


