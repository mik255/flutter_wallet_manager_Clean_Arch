import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../styles/text_styles.dart';
import '../../../home/presenter/widgets/billing_item_widget.dart';
import '../../../home/presenter/widgets/info_description.dart';
import '../../../home/presenter/widgets/input_and_output_card.dart';
import '../../data/repository/transactions_repository_impl.dart';
import '../../domain/models/transaction.dart';
import '../../domain/usecases/get_transactions_usecase.dart';
import 'manual_debit_form_register.dart';

TextEditingController _searchController = TextEditingController();

class TransactionsPage extends StatefulWidget {
  TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late GetTransactionsUseCase getTransactionsUseCase;
  List<Transaction> transactions = [];

  @override
  void initState() {
    getTransactionsUseCase = GetTransactionsUseCase(
      GetIt.I<TransactionRepositoryImpl>(),
    );
    getTransactionsUseCase.call().then((value) {
      setState(() {
        transactions = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoDescriptionWidget(
                  title: 'Entradas e Saídas',
                  description:
                      'Estes valores correspontem ao somatório do fluxo de entrada e saída de todas  as contas',
                  rightWidget: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManualDebitFormRegister(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: const ShapeDecoration(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              child: Text('Adicionar Despesa',
                                  style: CustomTextStyles()
                                      .smallSubtitle
                                      .copyWith(color: Colors.white, fontSize: 14)),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: InputAndOutputCard(),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: SearchWidget(
                      transactions: ValueNotifier([]),
                    )),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Resetar pesquisa'),
                ),
              ],
            ),
          ),
          if (false) const Center(child: LinearProgressIndicator()),
          if (transactions.isNotEmpty)
            Column(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return BillingItemTransactions(
                      transaction: transactions.elementAt(index),
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                ),
                const SizedBox(
                  height: 300,
                )
              ],
            )
          else
            Center(
                child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Builder(builder: (context) {
                return Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Nenhuma transação encontrada'),
                  const SizedBox(height: 16),
                  if (transactions.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('resetar pesquisa'),
                    ),
                ]));
              }),
            )),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.transactions});

  final ValueNotifier<List<BillingItemTransactions>> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        decoration: ShapeDecoration(
          color: const Color(0xFFE7EDFD),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Center(
          child: TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: 'Pesquisar...',
            ),
            onFieldSubmitted: (value) {
              transactions.value = transactions.value
                  .where((element) =>
                      element.transaction.name.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            },
          ),
        ));
  }
}
