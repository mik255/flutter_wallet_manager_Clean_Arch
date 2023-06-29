import 'package:flutter/material.dart';
import 'package:wallet_manager/app/home/widgets/billing_item_widget.dart';
import '../../../domain/models/transaction.dart';
import '../../../main_stances.dart';


List<Transaction> transactions = [];

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  bool loadng = true;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async{

    transactions = [];
    for (var element in MainStances.plugglyService.getBankAccounts) {
      element.balanceTypes
          .map((e) => e.transactions)
          .forEach((element) {
            transactions.addAll(element);
          });
    }
    print(transactions.length);
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        loadng = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loadng) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 16,
        children: [
          ...transactions
              .map((e) => BillingItemTransactions(transaction: e))
              .toList()
        ],
      ),
    );
  }
}
