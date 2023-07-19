import 'package:flutter/material.dart';
import 'app/modules/account/view/login_build.dart';
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
      home: const LoginBuild(),
    );
  }
}
