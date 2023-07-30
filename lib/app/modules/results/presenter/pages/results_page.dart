import 'package:flutter/material.dart';
import '../../../home/presenter/widgets/info_description.dart';
import '../widgets/radial_pie_chart.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _categoryResultsCardHeader(),
            Builder(builder: (cxt) {
              return const Column(
                children: [
                  RadialChartWidget(),
                  SizedBox(
                    height: 300,
                  )
                ],
              );
            })
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
