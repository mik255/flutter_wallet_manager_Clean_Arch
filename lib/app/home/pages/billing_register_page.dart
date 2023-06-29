import 'package:flutter/material.dart';

import '../../../controller/speech_to_text_controller.dart';
import '../../styles/button_decoretor.dart';
import '../../styles/container_decorators.dart';
import '../../styles/custom_text_field.dart';
import '../../styles/text_styles.dart';

class BillingRegisterPage extends StatefulWidget {
  BillingRegisterPage({super.key});

  @override
  State<BillingRegisterPage> createState() => _BillingRegisterPageState();
}

class _BillingRegisterPageState extends State<BillingRegisterPage> {

  SpeechToTextController speechToTextController = SpeechToTextController();
  String installments = '1x';
  bool listening = false;
  @override
  void initState() {
    speechToTextController.init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16),
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFDDE2EB),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 120,
                            width: 120,
                            decoration: ContainerDecorators().getBoxDecoration(
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  'https://t.ctcdn.com.br/3tQdC0dhzmQcV8uSocwIy8gtyic=/400x400/smart/filters:format(webp)/i624750.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'NuBank',
                                style: TextStyle(
                                  color: Color(0xFF3B3B3B),
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '\$ 2.450,00',
                                style: TextStyle(
                                  color: Color(0xFF3B3B3B),
                                  fontSize: 32,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                      child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: speechToTextController.controllerName,
                        decoration: CustomTextFieldDecorator()
                            .getInputDecorator('Nome',
                                color: const Color(0xFFF8F8F8)),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: speechToTextController
                                    .controllerPrice,
                                decoration: CustomTextFieldDecorator()
                                    .getInputDecorator(
                                  'Preço',
                                  color: const Color(0xFFF8F8F8),
                                ),
                              ),
                            ),
                            Expanded(child: MyDropdown()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        controller: speechToTextController
                            .controllerCategory,
                        decoration: CustomTextFieldDecorator()
                            .getInputDecorator(
                          'Categoria',
                          color: const Color(0xFFF8F8F8),
                        ),
                      ),
                    ],
                  )),
                ),
                SizedBox(height: 32),
                AnimatedBuilder(
                    animation: speechToTextController.text,
                    builder: (context, child) {
                      return Text(
                        speechToTextController.text.value == ''
                            ? 'Ex: tv de 55 polegadas, preço sinquenta em 10 vezes'
                            : speechToTextController.text.value,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }),
                const SizedBox(height: 16),
                AnimatedBuilder(
                  animation: speechToTextController.isListening,
                  builder: (context,child) {
                    return InkWell(
                      onTap: () {
                        if (speechToTextController.isListening.value == false) {
                          speechToTextController.startListening();
                        } else {
                          speechToTextController.stopListening();
                        }

                      },
                      child: Container(
                        width: 83.34,
                        height: 83.34,
                        decoration:  ShapeDecoration(
                          color: speechToTextController.isListening.value?Colors.red:const Color(0xFFDDDDDD),
                          shape: const OvalBorder(),
                        ),
                        child:  Center(
                          child: Text(
                            'record',
                            style: TextStyle(
                              color: speechToTextController.isListening.value?Colors.white:const Color(0xFF3B3B3B),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          )),
    );
  }
}

class MyDropdown extends StatefulWidget {
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String _selectedItem = 'Item 1';
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 80,
            child: DropdownButton<String>(
              value: _selectedItem,
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value!;
                });
              },
              items: _items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
