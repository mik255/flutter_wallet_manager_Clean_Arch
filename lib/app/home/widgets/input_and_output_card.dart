import 'package:flutter/material.dart';
import 'package:wallet_manager/domain/models/financial_results_calculator.dart';
import 'package:wallet_manager/main_stances.dart';
import 'package:wallet_manager/util/extensions/current_formate.dart';

import '../../shared_widgets/date_rage_piker.dart';

class InputAndOutputCard extends StatefulWidget {
  const InputAndOutputCard(
      {super.key, required this.financialResultsCalculator});

  final FinancialResultsCalculator financialResultsCalculator;

  @override
  State<InputAndOutputCard> createState() => _InputAndOutputCardState();
}

class _InputAndOutputCardState extends State<InputAndOutputCard> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var currentDateRange = MainStances.plugglyService.dataRange;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DateRangePickerWidget(
                  onDateSelected: (range) async {
                    setState(() {
                      loading = true;
                    });
                    await MainStances.plugglyService.updateTransactionsByRange(
                      range,
                      1,
                      limit: 500,
                    );
                    widget.financialResultsCalculator.calculate();
                    setState(() {
                      currentDateRange = range;
                      loading = false;
                    });
                  },
                  initialDate: currentDateRange),
              const Spacer(),
              if (loading)
                Container(
                  height: 16,
                  width: 16,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF0C1425)),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            runSpacing: 16,
            spacing: 16,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            children: [
              SizedBox(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: ShapeDecoration(
                  color: Color(0xFFF8F8F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const ShapeDecoration(
                        color: Colors.green,
                        shape: OvalBorder(),
                      ),
                      child: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: 12,
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
                            'Entrada',
                            style: TextStyle(
                              color: Color(0xFF505869),
                              fontSize: 13,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            widget.financialResultsCalculator.inputsBalance
                                .toCurrencyString(),
                            style: const TextStyle(
                              color: Color(0xFF0C1425),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
              SizedBox(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: ShapeDecoration(
                  color: Color(0xFFF8F8F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 24,
                        height: 24,
                        decoration: const ShapeDecoration(
                          color: Colors.red,
                          shape: OvalBorder(),
                        ),
                        child: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 12,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          child: Text(
                            'Saída',
                            style: TextStyle(
                              color: Color(0xFF505869),
                              fontSize: 13,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            widget.financialResultsCalculator.outputsBalance
                                .toCurrencyString(),
                            style: const TextStyle(
                              color: Color(0xFF0C1425),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
