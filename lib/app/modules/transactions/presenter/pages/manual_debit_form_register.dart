import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:wallet_manager/app/modules/transactions/domain/models/transaction.dart';
import '../../../../shared/widgets/select_string_page.dart';
import '../../data/repository/transactions_repository_impl.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/save_transaction_usecase.dart';

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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () async {
              SaveTransactionUseCase saveTransactionUseCase = SaveTransactionUseCase(
                GetIt.I<TransactionRepositoryImpl>(),
              );
              await saveTransactionUseCase.call(Transaction(
                category: TransactionCategory(
                  name: categoryController.text,
                  icon: Icons.add,
                ),
                name: nameController.text,
                date: DateTime.now().toIso8601String(),
                amount: double.parse(amountController.text),
                installments: 'installments',
                bankName: bankNameController.text,
                type: TransactionType.DEBIT,
              ));
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: "Salvo com sucesso",
                toastLength: Toast.LENGTH_SHORT,
                // Duração do Toast (SHORT ou LONG)
                gravity: ToastGravity.BOTTOM,
                // Posição do Toast na tela (TOP, BOTTOM, CENTER)
                backgroundColor: Colors.black54,
                // Cor de fundo do Toast
                textColor: Colors.white,
                // Cor do texto do Toast
                fontSize: 16.0, // Tamanho do texto do Toast
              );
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
            Padding(
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
                                list: const [
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
                                list: const [
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
            )
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
