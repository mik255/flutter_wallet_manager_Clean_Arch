import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet_manager/app/modules/results/domain/states/results_states.dart';
import 'package:wallet_manager/shared/extensions/current_formate.dart';

import '../../../home/domain/models/category.dart';
import '../controller.dart';
Color randomColor() {
  final Random random = Random();
  final int r = random.nextInt(255); // Intervalo de vermelho: 80-255
  final int g = random.nextInt(255); // Intervalo de verde: 80-255
  final int b = random.nextInt(255); // Intervalo de azul: 80-255
  return Color.fromRGBO(r, g, b, 0.6);
}
class RadialChartWidget extends StatefulWidget {
  const RadialChartWidget({
    super.key,
  });

  @override
  State<RadialChartWidget> createState() => _RadialChartWidgetState();
}

class _RadialChartWidgetState extends State<RadialChartWidget> with ResultsStates{
  ResultsController? resultsController;
  BehaviorSubject<Results> resultsValue = BehaviorSubject<Results>.seeded(Results(categories: []));
  @override
  void initState() {
    resultsController = ResultsController(this);
    resultsController!.calculate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: resultsValue.stream,
      builder: (context, snapshot) {
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1.3,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sections: resultsValue.value.categories
                          .map((e) => PieChartSectionData(
                                color: randomColor(),
                                value: e.totalValue.toDouble(),
                                title: e.name,
                                radius: 15,
                              ))
                          .toList(),
                      centerSpaceRadius: 85,
                    ),
                  ),
                  Center(
                    child: Text(
                      resultsValue.value.totalValue
                          .toDouble()
                          .toCurrencyString(),
                      style: const TextStyle(
                        color: Color(0xFF0C1425),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Builder(builder: (context) {
            //   data.sort((a, b) => b['value'].compareTo(a['value']));
            //   return Column(
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       ...data.map((e) => _legendItem(e)).toList(),
            //       ...listUnbled.map((e) => _legendItem({'name': e, 'value': -1.0})),
            //     ],
            //   );
            // }),
          ],
        );
      }
    );
  }

  // _legendItem(Map<String, dynamic> e) {
  //   if (e['value'] == 0) return const SizedBox();
  //   String title = e['name'];
  //   String subtitle = '';
  //   try {
  //     title = e['name'].split('-')[0];
  //     subtitle = e['name'].split('-')[1].trimLeft();
  //   } catch (e) {}
  //   return AnimatedOpacity(
  //     duration: const Duration(milliseconds: 500),
  //     opacity: e['value'] == -1 ? 0.5 : 1,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8.0),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: e['color'],
  //             ),
  //             width: 20,
  //             height: 20,
  //           ),
  //           const SizedBox(width: 8),
  //           Expanded(
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Container(
  //                             child: Text(
  //                           maxLines: 2,
  //                           title,
  //                           overflow: TextOverflow.ellipsis,
  //                         )),
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 4,
  //                     ),
  //                     if (e['value'] > -1)
  //                       Container(
  //                           padding: const EdgeInsets.all(2),
  //                           height: 20,
  //                           decoration: BoxDecoration(
  //                             color: const Color(0xFFE7EDFD),
  //                             borderRadius: BorderRadius.circular(4),
  //                           ),
  //                           child: Center(
  //                             child: Text(
  //                               '${(e['value'] as num).toStringAsFixed(2)}%',
  //                               style: const TextStyle(
  //                                 color: Color(0xFF0C1425),
  //                                 fontSize: 10,
  //                                 fontFamily: 'Roboto',
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           )),
  //                   ],
  //                 ),
  //                 if (e['value'] > -1) Spacer(),
  //                 if (e['value'] > -1)
  //                   Text((double.parse(e['total'].toString()).toCurrencyString())),
  //               ],
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () => onItemTap(e['name']),
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //               child: Container(
  //                   height: 24,
  //                   width: 24,
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     color: e['value'] > -1 ? Colors.grey[200] : Colors.transparent,
  //                     border: Border.all(
  //                         color: e['value'] > -1 ? Colors.transparent : Colors.grey[300]!,
  //                         width: 2),
  //                   ),
  //                   child: Center(
  //                       child: Icon(
  //                     e['value'] > -1 ? Icons.close : Icons.add,
  //                     color: e['value'] > -1 ? Colors.grey : Colors.black,
  //                     size: 14,
  //                   ))),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  void onCalculate(Results results) {
    resultsValue.value = results;
  }

  @override
  void onFilterByEnterOrOut(Results results) {
    // TODO: implement onFilterByEnterOrOut
  }
}
