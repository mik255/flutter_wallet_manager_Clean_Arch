import 'package:flutter/material.dart';
import 'package:wallet_manager/shared/main_stances.dart';
import 'package:wallet_manager/view/home/home_page.dart';
import 'package:wallet_manager/view/login/login_page.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            primary: Colors.blue,
            secondary: Colors.white,
            seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:  HomePage(),
    );
  }
}


