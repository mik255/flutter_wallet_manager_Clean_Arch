import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import '../../../shared/state/base_view_listener.dart';
import '../domain/interactors/auth_view_model/auth_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthViewModel viewModel = Provider.of<AuthViewModel>(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: Column(
          children: [
            SizedBox(
              height:24,
              child: StateBindListenerWithListenable(
                states: [viewModel.state.errorListener],
                child: Text(
                  viewModel.state.getErrorValue(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Padding(
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
                    await viewModel.singIn();
                  },
                ),
              ),
            ),
          ],
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
}
