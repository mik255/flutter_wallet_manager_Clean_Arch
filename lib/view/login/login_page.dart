import 'package:flutter/material.dart';
import 'package:wallet_manager/controller/login_controller.dart';
import 'package:wallet_manager/data/preferences_helper.dart';
import 'package:wallet_manager/shared/main_stances.dart';
import '../../models/user.dart';
import '../designer_system/button_decoretor.dart';
import '../designer_system/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper helper = SharedPreferencesHelper(
      MainStances.preferences,
    );
    var user = User(
      email: emailController.text,
      password: passwordController.text,
    );
    LoginController controller = LoginController(
      user: user,
      helper: helper,
    );
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white70,
              child: Icon(
                Icons.monetization_on_outlined,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (!user.validateEmail()) {
                          return 'Email is not valid';
                        }
                        return null;
                      },
                      decoration:
                          CustomTextFieldDecorator().getInputDecorator('Email'),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (!user.validatePassword()) {
                          return 'password is not valid';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: CustomTextFieldDecorator()
                          .getInputDecorator('Password'),
                    ),
                    const SizedBox(height: 16.0),
                    AnimatedBuilder(
                        animation: controller.message,
                        builder: (context, child) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                              controller.message.value,
                            ),
                          );
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: CustomButtonStyle().getStyle(),
                              onPressed: controller.login,
                              child: const Text('Enter'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
