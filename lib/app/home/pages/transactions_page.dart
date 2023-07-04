import 'package:flutter/material.dart';
import 'package:wallet_manager/app/home/widgets/billing_item_widget.dart';
import 'package:wallet_manager/domain/models/transaction.dart';
import '../../../main_stances.dart';
import '../../shared_widgets/date_rage_piker.dart';

ValueNotifier<List<BillingItemTransactions>> transactions =
    ValueNotifier<List<BillingItemTransactions>>([]);
TextEditingController _searchController = TextEditingController();
class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  bool loadng = true;
  final ScrollController _scrollController = ScrollController();
  int page = 0;

  @override
  void initState() {
    loadMore();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  loadMore() async {
    page++;
    setState(() {
      loadng = true;
    });
    await MainStances.plugglyService.updateTransactionsByRange(
      MainStances.plugglyService.dataRange,
      page,
    );
    setState(() {
      loadng = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !loadng) {
      loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    transactions.value = MainStances.plugglyService.getBankAccounts
        .expand((element) =>
            element.balanceTypes.expand((element) => element.transactions))
        .map((e) => BillingItemTransactions(transaction: e))
        .toList();
    var allTransactions = transactions.value;
    return AnimatedBuilder(
      animation: transactions,
      builder: (context, child) => SingleChildScrollView(
        //controller: _scrollController,
        child: Wrap(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(child: SearchWidget()),
                ],
              ),
            ),
            if (loadng) const Center(child: LinearProgressIndicator()),
            if (transactions.value.isNotEmpty)
              Column(
                children: [
                  ...transactions.value,
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
                  if (loadng) {
                    return const Center(child: Text('carregando...'));
                  }
                  return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        const Text('Nenhuma transação encontrada'),
                        const SizedBox(height: 16),
                        if(allTransactions.isNotEmpty)
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
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

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
