import 'package:flutter/material.dart';
import '../../../../styles/button_decoretor.dart';
import '../../../../styles/custom_text_field.dart';

class CardFieldLogin extends StatelessWidget {
  const CardFieldLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                    CustomTextFieldDecorator().getInputDecorator('Email'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration:
                    CustomTextFieldDecorator().getInputDecorator('Password'),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: CustomButtonStyle().getStyle(),
                        onPressed: () {},
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
    );
  }
}
