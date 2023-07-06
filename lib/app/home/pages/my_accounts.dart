import 'package:flutter/material.dart';

import '../../../domain/models/financial_results_calculator.dart';
import '../../../main_stances.dart';
import '../../styles/text_styles.dart';
import '../widgets/billing_item_widget.dart';
import '../widgets/info_description.dart';
import '../widgets/input_and_output_card.dart';

class MyAccounts extends StatefulWidget {
  const MyAccounts({
    super.key,
    required this.financialResultsCalculator,
    this.onAddAccount,
  });

  final Function()? onAddAccount;
  final FinancialResultsCalculator financialResultsCalculator;

  @override
  State<MyAccounts> createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoDescriptionWidget(
                    title: 'Entradas e Saídas',
                    description:
                        'Estes valores correspontem ao somatório do fluxo de entrada e saída de todas  as contas',
                    rightWidget: Container(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InputAndOutputCard(
                  financialResultsCalculator: widget.financialResultsCalculator,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InfoDescriptionWidget(
                    rightWidget: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: const ShapeDecoration(
                                        color: Color(0xFFF5F6F9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0)),
                                        ),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 4,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: FadeTransition(
                                        opacity:
                                            Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                                          parent: AnimationController(
                                            duration: const Duration(milliseconds: 1500),
                                            vsync: this,
                                          )..forward(),
                                          curve: Curves.easeInOut,
                                        )),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: widget.onAddAccount,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(vertical: 16),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.account_balance_outlined,
                                                          color: Color(0xFF2D9CDB),
                                                          size: 24,
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Text(
                                                          'Instituição financeira',
                                                          style: CustomTextStyles().smallSubtitle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(vertical: 16),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.more_time_rounded,
                                                          color: Color(0xFF2D9CDB),
                                                          size: 24,
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Text(
                                                          'Conta Períodica',
                                                          style: CustomTextStyles().smallSubtitle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(vertical: 16),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.calendar_month,
                                                          color: Color(0xFF2D9CDB),
                                                          size: 24,
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Text(
                                                          'Conta Agendada',
                                                          style: CustomTextStyles().smallSubtitle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: const ShapeDecoration(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              child: Text('Adicionar',
                                  style: CustomTextStyles()
                                      .smallSubtitle
                                      .copyWith(color: Colors.white, fontSize: 14)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: 'Contas',
                    description:
                        'Estes valores correspontem ao preiodo de tempo atual de cada conta individualmente',
                  ),
                ],
              ),
              ...List.generate(
                  MainStances.plugglyService.getBankAccounts.length,
                  (index) => BillingItemWidget(
                      bankAccount: MainStances.plugglyService.getBankAccounts.toList()[index])),
              Container(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
