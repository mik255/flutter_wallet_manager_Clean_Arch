import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/modules/account/domain/states/auth_states.dart';

import '../../../../shared/widgets/select_string_page.dart';
import '../../domain/interactors/home_view_model_impl.dart';
import '../../domain/models/bank_account.dart';
import '../../domain/viewmodels/home_view_model.dart';

class ManualDebitFormRegister extends StatelessWidget {
  ManualDebitFormRegister({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController installmentsController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeviewmodel = GetIt.I<HomeViewModelImpl>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              var ok = homeviewmodel.registerBankAccount(
                BankAccount(
                  balanceTypes: [],
                  name: nameController.text,
                  owner: AuthState.currentUser.name,
                  logo: '',
                  id: Random().nextInt(1000).toString(),
                ),
              );
              if (ok) {
                Navigator.pop(context);
              }
            },
            child: const Text('Salvar'),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/register_manual_debit_background.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            homeviewmodel.bind.onBindListener(() {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _header(),
                        _formFild(
                            'Nome',
                            'ex: Conta de luz',
                            '',
                            (value) => {
                                  // nameController.text = value,
                                },
                            null,
                            controller: nameController),
                        _formFild(
                            'Preço',
                            'R\$ 100,00',
                            '',
                            (value) => {
                                  // viewModel.transaction.amount = double.parse(value),
                                },
                            null,
                            formatter: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            controller: amountController),
                        _formFild('Categoria', 'Selecione uma categoria', '', (value) => {},
                            Icons.arrow_drop_down, onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SelectString(
                                  list: [
                                    'Alimentação',
                                    'Educação',
                                    'Lazer',
                                    'Moradia',
                                    'Saúde',
                                    'Transporte',
                                    'Outros'
                                  ],
                                  onSelect: (value) {
                                    categoryController.text = value;
                                  },
                                );
                              });
                        }, controller: categoryController),
                        _formFild('Banco', 'ex: NuBank', '', (value) => {}, Icons.arrow_drop_down,
                            onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SelectString(
                                  list: [
                                    'NuBank',
                                    'Banco do Brasil',
                                    'Caixa',
                                    'Santander',
                                    'Itaú',
                                    'Bradesco',
                                    'Outros'
                                  ],
                                  onSelect: (value) {
                                    bankNameController.text = value;
                                  },
                                );
                              });
                        }, controller: bankNameController),
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  _header() {
    return Container(
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'cadastre uma',
            style: TextStyle(
              color: Color(0xFF3B3B3B),
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'DESPESA',
            style: TextStyle(
              color: Color(0xFF3B3B3B),
              fontSize: 32,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      'Cadastre uma despesa de forma manual, vc tbm pode cadastrar uma despesa de forma automática selecionando uma \n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: 'instituição financeira',
                  style: TextStyle(
                    color: Color(0xFF4472CA),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 48,
          )
        ],
      ),
    );
  }

  _formFild(String label, String hint, String value, Function(String) onChanged, IconData? icon,
      {Function()? onTap, List<TextInputFormatter>? formatter, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: controller,
          inputFormatters: formatter,
          onTap: onTap,
          readOnly: onTap != null,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hint,
            suffixIcon: icon != null ? Icon(icon) : null,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
        ),
      ),
    );
  }
}