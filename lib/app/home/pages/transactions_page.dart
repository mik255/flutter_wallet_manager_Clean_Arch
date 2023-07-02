import 'package:flutter/material.dart';
import 'package:wallet_manager/app/home/widgets/billing_item_widget.dart';
import '../../../main_stances.dart';

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
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent&& !loadng) {
      loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    var transactions =  MainStances.plugglyService.getBankAccounts
        .expand((element) => element.balanceTypes
        .expand((element) => element.transactions))
        .map((e) => BillingItemTransactions(transaction: e))
        .toList();
    return SingleChildScrollView(
      //controller: _scrollController,
      child: Wrap(
        children: [
          if (loadng) const Center(child: LinearProgressIndicator()),
          if(transactions.isNotEmpty)
          ...transactions
          else
            const Center(child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('Nenhuma transação encontrada'),
            )),

        ],
      ),
    );
  }
}
