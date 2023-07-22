import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/interactors/home_view_model_impl.dart';
import '../../domain/state/home_view_model.dart';
import '../../domain/viewmodels/home_view_model.dart';
import '../widgets/billing_item_widget.dart';
import '../widgets/info_description.dart';
import '../widgets/input_and_output_card.dart';

TextEditingController _searchController = TextEditingController();

class TransactionsPage extends StatelessWidget {
    TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeviewmodel = GetIt.instance<HomeViewModelImpl>();
    return homeviewmodel.bind.onBindListener(
            () {
          if (homeviewmodel.bind.state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          var allTransactions = (homeviewmodel.bind.state as HomeLoadedState).bankAccounts!
              .expand((element) => element.balanceTypes).expand((element) => element.transactions);
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
                        rightWidget: Container(),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
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
                                transactions:ValueNotifier([]),
                              )),
                        ],
                      ),
                        TextButton(
                          onPressed: () {

                          },
                          child: const Text('Resetar pesquisa'),
                        ),
                    ],
                  ),
                ),
                if (false)
                  const Center(child: LinearProgressIndicator()),
                if (allTransactions.isNotEmpty)
                  Column(
                    children: [
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return BillingItemTransactions(
                            transaction: allTransactions.elementAt(index),
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:allTransactions.length,
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
                          if (false) {
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
                                        },
                                        child: const Text('resetar pesquisa'),
                                      ),
                                  ]));
                        }),
                      )),
              ],
            ),
          );
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
                  .where((element) =>
                  element.transaction.name
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            },
          ),
        ));
  }
}
