
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/home/view_models/home_load_data.dart';
import 'package:wallet_manager/app/home/widgets/billing_item_widget.dart';
import 'package:wallet_manager/domain/usecases/instances.dart';
import '../../../domain/usecases/calculators/financial_results_calculator.dart';
import '../../../main_stances.dart';
import '../widgets/info_description.dart';
import '../widgets/input_and_output_card.dart';

TextEditingController _searchController = TextEditingController();

class ComputeValues {
  ValueNotifier<List<BillingItemTransactions>> transactions;
  List<BillingItemTransactions> allTransactions;
  FinancialResultsCalculator financialResultsCalculator;

  ComputeValues(
      {required this.transactions,
      required this.financialResultsCalculator,
      required this.allTransactions});
}

Future<ComputeValues> computeCalcuc(ComputeValues computeValues,HomeViewModel homeViewModel) async {
  computeValues.transactions.value = currentBankAccounts
      .expand((element) =>
          element.balanceTypes.expand((element) => element.transactions))
      .map((e) => BillingItemTransactions(transaction: e))
      .toList();

  computeValues.financialResultsCalculator = FinancialResultsCalculator();
  return computeValues;
}

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {

  int page = 0;
  @override
  void initState() {
    _searchController.text = '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var homeviewmodel = context.read<HomeViewModel>();
    return AnimatedBuilder(
        animation: homeviewmodel.loading,
        builder: (context, child) {
          if (homeviewmodel.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return FutureBuilder<ComputeValues>(
              future: computeCalcuc(
                  ComputeValues(
                      transactions: ValueNotifier<List<BillingItemTransactions>>([]),
                      financialResultsCalculator:  FinancialResultsCalculator(
                      ),
                    allTransactions: [],
                  ),homeviewmodel),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16.0,
                        ),
                        Text('calculando...'),
                      ],
                    ),
                  ));
                }
                var allTransactions = snapshot.data!.allTransactions;
                return AnimatedBuilder(
                  animation: snapshot.data!.transactions,
                  builder: (context, child) => SingleChildScrollView(
                    //controller: _scrollController,
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
                                rightWidget: Container(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: InputAndOutputCard(
                            financialResultsCalculator:
                                snapshot.data!.financialResultsCalculator,
                          ),
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
                                    transactions: snapshot.data!.transactions,
                                  )),
                                ],
                              ),
                              if (snapshot.data!.transactions.value.length <
                                  allTransactions.length)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchController.text = '';
                                    });
                                  },
                                  child: const Text('Resetar pesquisa'),
                                ),
                            ],
                          ),
                        ),
                        if (homeviewmodel.loading.value)
                          const Center(child: LinearProgressIndicator()),
                        if (snapshot.data!.transactions.value.isNotEmpty)
                          Column(
                            children: [
                              ListView.builder(
                                itemBuilder: (context, index) {
                                  return snapshot
                                      .data!.transactions.value[index];
                                },
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    snapshot.data!.transactions.value.length,
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
                              if (homeviewmodel.loading.value) {
                                return const Center(
                                    child: Text('carregando...'));
                              }
                              return Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    const Text('Nenhuma transação encontrada'),
                                    const SizedBox(height: 16),
                                    if (allTransactions.isNotEmpty)
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _searchController.text = '';
                                          });
                                        },
                                        child: const Text('resetar pesquisa'),
                                      ),
                                  ]));
                            }),
                          )),
                      ],
                    ),
                  ),
                );
              });
        });
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
                  .where((element) => element.transaction.name
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            },
          ),
        ));
  }
}
