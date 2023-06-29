import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/home/pages/home_page.dart';
import 'package:wallet_manager/app/view_models/user_viewmodel.dart';
import 'package:wallet_manager/data/preferences_helper.dart';
import 'package:wallet_manager/shared/main_stances.dart';
import '../../services/auth/google_login_impl.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    UserViewModel viewModel = Provider.of<UserViewModel>(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: SizedBox(
            height: 80,
            child: SignInButton(
              Buttons.Google,
              shape: //circleBorder,
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () async {
                await viewModel
                    .login(
                      GoogleLoginServiceImpl(),
                    )
                    .then((value) => value ? goTohome(context) : null);
              },
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(
                flex: 3,
              ),
              Text(
                'Wallet Manager',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Aqui voce tem controle total sobre todos os seus gastos !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void goTohome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
