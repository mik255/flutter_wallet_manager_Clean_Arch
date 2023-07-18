

import 'package:flutter/material.dart';
import 'package:wallet_manager/app/modules/home/widgets/values_header_info.dart';

import '../../../shared/widgets/date_rage_piker.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ValuesHeaderInfo(
                      financialResultsCalculator: financialResultsCalculator,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DateRangePickerWidget(
                        initialDate: homeviewmodel.dataRange,
                        onDateSelected: (date) async {
                          //homeviewmodel.updateTransactionsByRange(date);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
