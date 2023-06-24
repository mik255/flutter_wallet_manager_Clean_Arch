import 'package:flutter/material.dart';
import 'package:wallet_manager/controller/login_controller.dart';
import 'package:wallet_manager/data/preferences_helper.dart';
import 'package:wallet_manager/shared/mainStances.dart';
import '../../models/user.dart';

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
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
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
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (user.validatePassword()) {
                    return 'password is not valid';
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 16.0),
              AnimatedBuilder(
                  animation: controller.message,
                  builder: (context, child) {
                    return Text(
                      controller.message.value,
                    );
                  }),
              ElevatedButton(
                onPressed: controller.login,
                child: const Text('Enter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
