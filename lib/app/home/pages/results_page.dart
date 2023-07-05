import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet_manager/app/home/pages/transactions_page.dart';
import 'package:wallet_manager/app/home/widgets/info_description.dart';
import 'package:wallet_manager/domain/models/transaction.dart';

import '../../../domain/models/bank_account.dart';
import '../../../domain/models/financial_results_calculator.dart';
import '../../../main_stances.dart';
import '../../shared_widgets/date_rage_piker.dart';
import '../widgets/input_and_output_card.dart';
import '../widgets/radial_pie_chart.dart';

Color randomColor() {
  final Random random = Random();
  final int r = 80 + random.nextInt(255); // Intervalo de vermelho: 80-255
  final int g = 80 + random.nextInt(176); // Intervalo de verde: 80-255
  final int b = 80 + random.nextInt(176); // Intervalo de azul: 80-255
  return Color.fromRGBO(
      random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
}

const String resultsTitle =
    'Estes valores correspontem ao somatório de entrada e saída de todas  de contas, selecione uma conta para filtrar individualmente';

String getName(Transaction transaction) {
  String title = transaction.name;
  try {
    title = transaction.name.split('-')[0];
  } catch (e) {}
  return title;
}

Future<List<Map<String, dynamic>>> _computeResult(Set<BankAccount> list) async {
  try {
    var allItems = list
        .expand((element) =>
            element.balanceTypes.expand((element) => element.transactions))
        .map((e) => {
              'name': getName(e),
              'value': e.type == TransactionType.DEBIT
                  ? e.amount.abs()
                  : 0,
            })
        .toSet();
    allItems.removeWhere((element) => element['value'] == 0);
    allItems.removeWhere((element) => ['Dinheiro guardado','Dinheiro resgatado'].contains(element['name']));
    var total = allItems.map((e) => e['value'] as num).reduce((value, element) => value + element);

    var resultNames = allItems.map((e) => e['name']).toSet();
    var resultValues = resultNames
        .map((e) => {
              'color': randomColor(),
              'name': e,
              'total': allItems
                  .where((element) => element['name'] == e)
                  .map((e) => e['value'] as num)
                  .reduce((value, element) => value + element),
              'value': (allItems
                          .where((element) => element['name'] == e)
                          .map((e) => e['value'] as num)
                          .reduce((value, element) => value + element) *
                      100) /
                  (total == 0 ? 1 : total),
            })
        .toList();
    return resultValues;
  } catch (e) {
    return [];
  }
}

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    FinancialResultsCalculator financialResultsCalculator =
        FinancialResultsCalculator(
            allBanks: MainStances.plugglyService.getBankAccounts.toList());

    return FutureBuilder(
        future:
            compute(_computeResult, MainStances.plugglyService.getBankAccounts),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          var resultValues = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                //_categoryResultsCardHeader(),
                _radialChart(resultValues),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                //   child: InputAndOutputCard(
                //     financialResultsCalculator: financialResultsCalculator,
                //   ),
                // ),
                SizedBox(
                  height: 300,
                )
              ],
            ),
          );
        });
  }

  _categoryResultsCardHeader() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              InfoDescriptionWidget(
                title: 'Resulados',
                description: resultsTitle,
                rightWidget: Container(),
              ),
              DateRangePickerWidget(
                initialDate: MainStances.plugglyService.dataRange,
                onDateSelected: (date) async {
                  setState(() {
                    loading = true;
                  });
                  await MainStances.plugglyService
                      .updateTransactionsByRange(date, 1);
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _radialChart(List<Map<String, dynamic>> data) {
    data = data.map((e) => e..['color'] = randomColor()).toList();
    return RadialChartWidget(
      data: data,
    );
  }
}
