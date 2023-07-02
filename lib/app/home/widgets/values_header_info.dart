import 'package:flutter/material.dart';
import 'package:wallet_manager/util/extensions/current_formate.dart';

import '../../../domain/models/financial_results_calculator.dart';

class ValuesHeaderInfo extends StatelessWidget {
  const ValuesHeaderInfo({super.key, required this.financialResultsCalculator});

  final FinancialResultsCalculator financialResultsCalculator;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Somatório de todas as contas',
              style: TextStyle(
                color: Color(0x660C1425),
                fontSize: 10,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              financialResultsCalculator.balance.toCurrencyString(),
              style: const TextStyle(
                color: Color(0xFF0C1425),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            _getBalance(),
          ],
        ),
        Spacer(),
        const Icon(
          Icons.more_vert,
          color: Color(0xFFB2B8C3),
          size: 24,
        )
      ],
    );
  }

  _getBalance() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const ShapeDecoration(
                color: Color(0xFFB2B8C3),
                shape: OvalBorder(),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  child: Text(
                    'Crédito',
                    style: TextStyle(
                      color: Color(0xFF505869),
                      fontSize: 10,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  child: Text(
                    financialResultsCalculator.creditCardBalance
                        .toCurrencyString(),
                    style: const TextStyle(
                      color: Color(0xFF0C1425),
                      fontSize: 10,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const ShapeDecoration(
                color: Color(0xFFB2B8C3),
                shape: OvalBorder(),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  child: Text(
                    'Poupança',
                    style: TextStyle(
                      color: Color(0xFF505869),
                      fontSize: 10,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  child: Text(
                    financialResultsCalculator.savingsBalance
                        .toCurrencyString(),
                    style: const TextStyle(
                      color: Color(0xFF0C1425),
                      fontSize: 10,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
