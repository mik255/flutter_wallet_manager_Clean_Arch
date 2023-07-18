import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wallet_manager/shared/extensions/current_formate.dart';

class RadialChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Function(String) onItemTap;
  final List<String> listUnbled;

  const RadialChartWidget({
    super.key,
    required this.data,
    required this.onItemTap,
    required this.listUnbled,
  });

  @override
  Widget build(BuildContext context) {
    var list = data
        .map(
          (e) => PieChartSectionData(
            value: e['value'],
            color: e['color'],
            title: '',
            radius: 25,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        )
        .toList();
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  sections: list,
                  centerSpaceRadius: 100,
                ),
              ),
              Center(
                child: Text(
                  data
                      .map((e) => e['total'] as num)
                      .reduce((value, element) => value + element)
                      .toDouble()
                      .toCurrencyString(),
                  style: const TextStyle(
                    color: Color(0xFF0C1425),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Builder(builder: (context) {
          data.sort((a, b) => b['value'].compareTo(a['value']));
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...data.map((e) => _legendItem(e)).toList(),
              ...listUnbled.map((e) => _legendItem({'name': e, 'value': -1.0})),
            ],
          );
        }),
      ],
    );
  }

  _legendItem(Map<String, dynamic> e) {
    if (e['value'] == 0) return const SizedBox();
    String title = e['name'];
    String subtitle = '';
    try {
      title = e['name'].split('-')[0];
      subtitle = e['name'].split('-')[1].trimLeft();
    } catch (e) {}
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: e['value'] == -1 ? 0.5 : 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: e['color'],
              ),
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            maxLines: 2,
                            title,
                            overflow: TextOverflow.ellipsis,
                          )),

                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      if (e['value'] > -1)
                        Container(
                            padding: const EdgeInsets.all(2),
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE7EDFD),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '${(e['value'] as num).toStringAsFixed(2)}%',
                                style: const TextStyle(
                                  color: Color(0xFF0C1425),
                                  fontSize: 10,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )),
                    ],
                  ),
                  if (e['value'] > -1) Spacer(),
                  if (e['value'] > -1)
                    Text((double.parse(e['total'].toString()).toCurrencyString())),
                ],
              ),
            ),
            InkWell(
              onTap: () => onItemTap(e['name']),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: e['value'] > -1?Colors.grey[200]:Colors.transparent,
                      border: Border.all(color: e['value'] > -1?Colors.transparent:Colors.grey[300]!,width: 2),
                    ),
                    child:  Center(
                        child:
                           Icon(
                           e['value'] > -1? Icons.close :
                              Icons.add,
                              color: e['value'] > -1?Colors.grey:Colors.black,
                              size: 14,
                            ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
