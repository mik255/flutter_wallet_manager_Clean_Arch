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
  final int r = random.nextInt(255); // Intervalo de vermelho: 80-255
  final int g = random.nextInt(255); // Intervalo de verde: 80-255
  final int b = random.nextInt(255); // Intervalo de azul: 80-255
  return Color.fromRGBO(
      r, g, b, 0.6);
}

const String resultsTitle =
    'Estes valores correspontem ao somatório de entrada ou saída de todas  as contas. Para retirar um item do somatório, basta clicar no mesmo.';

String getName(Transaction transaction,bool isMainCategory) {
  if(isMainCategory){
    return transaction.category.category;
  }
  String title = transaction.name;

  return title;
}

TransactionType type = TransactionType.DEBIT;
List<String> removeList = [
  'Movimentação de Saldo',
];
Future<List<Map<String, dynamic>>> _computeResult(Set<BankAccount> list) async {
  try {
    var allItems = list
        .expand((element) =>
            element.balanceTypes.expand((element) => element.transactions))
        .map((e) => {
              'name': getName(e,true),
              'value': e.type == type
                  ? e.amount.abs()
                  : 0,
            })
        .toSet();
    allItems.removeWhere((element) => element['value'] == 0);
    allItems.removeWhere((element) => removeList.contains(element['name']));
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _categoryResultsCardHeader(),
            FutureBuilder(
                future: _computeResult(MainStances.plugglyService.getBankAccounts),
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
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  var resultValues = snapshot.data!;
                  return Column(
                    children: [

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
                  );
                }),
          ],
        ),
      ),
    );
  }

  _categoryResultsCardHeader() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              InfoDescriptionWidget(
                title: 'Resulados',
                description: resultsTitle,
                rightWidget: Container(),
              ),
              Spacer(),
              SwitchWithText(
                onChanged: (value) {
                  setState(() {});
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
      listUnbled: removeList,
      onItemTap: (title) {
        setState(() {
          if(removeList.contains(title)){
            removeList.remove(title);
            return;
          }
          removeList.add(title);
          removeList.toSet().toList();
        });

      },
    );
  }
}

class SwitchWithText extends StatefulWidget {
  const SwitchWithText({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final Function(bool) onChanged;
  @override
  _SwitchWithTextState createState() => _SwitchWithTextState();
}

class _SwitchWithTextState extends State<SwitchWithText> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 0.75,
              child: Switch(
              activeColor: Colors.green,
                value: type == TransactionType.CREDIT?true:false,
                onChanged: (value) {
                  setState(() {
                    type = TransactionType.CREDIT;
                    widget.onChanged(value);
                  });
                },
              ),
            ),
            const SizedBox(width: 4),
            const Text('Entrada'),
          ],
        ),
        Row(
          children: [
            Transform.scale(
              scale: 0.75,
              child: Switch(
                activeColor: Colors.red,
                value: type == TransactionType.DEBIT?true:false,
                onChanged: (value) {
                  setState(() {
                    type = TransactionType.DEBIT;
                    widget.onChanged(value);
                  });
                },
              ),
            ),
            const SizedBox(width: 4),
            const Text('Saída'),
          ],
        ),
      ],
    );
  }
}