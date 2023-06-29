import 'package:flutter/material.dart';
import 'package:wallet_manager/controller/login_controller.dart';
import 'package:wallet_manager/data/preferences_helper.dart';
import 'package:wallet_manager/shared/main_stances.dart';
import '../../models/user.dart';
import '../styles/button_decoretor.dart';
import '../styles/custom_text_field.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper helper = SharedPreferencesHelper(
      MainStances.preferences,
    );


    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Wrap(
                  children: [
                    Text(
                      'Wallet Manager',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
