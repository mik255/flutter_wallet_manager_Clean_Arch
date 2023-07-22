import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/modules/home/domain/state/home_view_model.dart';
import '../../domain/viewmodels/home_view_model.dart';
import '../widgets/info_description.dart';

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


class ResultsPage extends StatefulWidget {
    ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {


  @override
  Widget build(BuildContext context) {
    var homeviewmodel = context.read<HomeViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _categoryResultsCardHeader(),
            homeviewmodel.bind.onBindListener(
                 () {
                  if (homeviewmodel.bind.state is HomeLoadingState) {
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

                  return const Column(
                    children: [
                     // _radialChart(),
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
            ],
          )
        ],
      ),
    );
  }

//   Widget _radialChart(List<Map<String, dynamic>> data) {
//     data = data.map((e) => e..['color'] = randomColor()).toList();
//     return RadialChartWidget(
//       data: data,
//       listUnbled: removeList,
//       onItemTap: (title) {
//
//       },
//     );
//   }
 }
//
// class SwitchWithText extends StatefulWidget {
//   const SwitchWithText({
//     Key? key,
//     required this.onChanged,
//   }) : super(key: key);
//   final Function(bool) onChanged;
//   @override
//   _SwitchWithTextState createState() => _SwitchWithTextState();
// }
//
// class _SwitchWithTextState extends State<SwitchWithText> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Transform.scale(
//               scale: 0.75,
//               child: Switch(
//               activeColor: Colors.green,
//                 value: type == TransactionType.CREDIT?true:false,
//                 onChanged: (value) {
//                   setState(() {
//                     type = TransactionType.CREDIT;
//                     widget.onChanged(value);
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(width: 4),
//             const Text('Entrada'),
//           ],
//         ),
//         Row(
//           children: [
//             Transform.scale(
//               scale: 0.75,
//               child: Switch(
//                 activeColor: Colors.red,
//                 value: type == TransactionType.DEBIT?true:false,
//                 onChanged: (value) {
//                   setState(() {
//                     type = TransactionType.DEBIT;
//                     widget.onChanged(value);
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(width: 4),
//             const Text('Saída'),
//           ],
//         ),
//       ],
//     );
//   }
// }