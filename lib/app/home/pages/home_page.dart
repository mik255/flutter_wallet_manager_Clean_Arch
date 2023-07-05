import 'package:flutter/material.dart';
import 'package:flutter_pluggy_connect/flutter_pluggy_connect.dart';
import 'package:wallet_manager/app/home/pages/results_page.dart';
import 'package:wallet_manager/app/home/pages/transactions_page.dart';
import 'package:wallet_manager/app/home/widgets/billing_item_widget.dart';
import 'package:wallet_manager/app/home/widgets/perfil.dart';
import 'package:wallet_manager/app/shared_widgets/balance_info.dart';
import 'package:wallet_manager/domain/models/financial_results_calculator.dart';
import 'package:wallet_manager/util/extensions/current_formate.dart';

import '../../../main_stances.dart';
import '../../shared_widgets/date_rage_piker.dart';
import '../../shared_widgets/load_lottie_widgets.dart';
import '../../styles/text_styles.dart';
import '../widgets/info_description.dart';
import '../widgets/input_and_output_card.dart';
import '../widgets/values_header_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.needLoadData});

  final bool needLoadData;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool showPlugglyConnect = false;
  late TabController _tabController;
  bool menuOpened = false;
  bool loading = false;
  String currentItemId = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadInitialData();
  }

  loadInitialData() async {
    loading = true;
    if (widget.needLoadData) {
      await MainStances.plugglyService.loadData();
    }
    setState(() {
      loading = false;
    });
  }

  getNewAccount() async {
    setState(() {
      loading = true;
    });
    await MainStances.plugglyService.getAccount(currentItemId);
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FinancialResultsCalculator financialResultsCalculator =
        FinancialResultsCalculator(
            allBanks: MainStances.plugglyService.getBankAccounts.toList());
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          if (loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (showPlugglyConnect) {
            return PluggyConnect(
              connectToken: MainStances.plugglyService.accessToken,
              onSuccess: (data) {
                currentItemId = data['item']['id'];
              },
              onClose: () {
                getNewAccount();
                showPlugglyConnect = false;
              },
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: const Color(0x42D9D9D9),
                  height: 56,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PerfilWidget(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        await MainStances.plugglyService.updateAllItem();
                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/home_background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ValuesHeaderInfo(
                                  financialResultsCalculator:
                                      financialResultsCalculator,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  DateRangePickerWidget(
                                    initialDate:
                                        MainStances.plugglyService.dataRange,
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
                              ),
                            ],
                          ),

                        ],
                      ),
                    )),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Minhas Contas'),
                    Tab(text: 'Transações'),
                    Tab(text: 'Resultados'),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16),
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        Scaffold(
                          body: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: InputAndOutputCard(
                                    financialResultsCalculator:
                                        financialResultsCalculator,
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            const ShapeDecoration(
                                                          color:
                                                              Color(0xFFF5F6F9),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        16.0)),
                                                          ),
                                                          shadows: [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0x3F000000),
                                                              blurRadius: 4,
                                                              offset:
                                                                  Offset(0, 4),
                                                              spreadRadius: 0,
                                                            )
                                                          ],
                                                        ),
                                                        child: FadeTransition(
                                                          opacity: Tween<
                                                                      double>(
                                                                  begin: 0,
                                                                  end: 1)
                                                              .animate(
                                                                  CurvedAnimation(
                                                            parent:
                                                                AnimationController(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1500),
                                                              vsync: this,
                                                            )..forward(),
                                                            curve: Curves
                                                                .easeInOut,
                                                          )),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        showPlugglyConnect =
                                                                            true;
                                                                        menuOpened =
                                                                            false;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              16),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.account_balance_outlined,
                                                                            color:
                                                                                Color(0xFF2D9CDB),
                                                                            size:
                                                                                24,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                16,
                                                                          ),
                                                                          Text(
                                                                            'Instituição financeira',
                                                                            style:
                                                                                CustomTextStyles().smallSubtitle,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Divider(),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        showPlugglyConnect =
                                                                            true;
                                                                        menuOpened =
                                                                            false;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              16),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.more_time_rounded,
                                                                            color:
                                                                                Color(0xFF2D9CDB),
                                                                            size:
                                                                                24,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                16,
                                                                          ),
                                                                          Text(
                                                                            'Conta Períodica',
                                                                            style:
                                                                                CustomTextStyles().smallSubtitle,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Divider(),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        showPlugglyConnect =
                                                                            true;
                                                                        menuOpened =
                                                                            false;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              16),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.calendar_month,
                                                                            color:
                                                                                Color(0xFF2D9CDB),
                                                                            size:
                                                                                24,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                16,
                                                                          ),
                                                                          Text(
                                                                            'Conta Agendada',
                                                                            style:
                                                                                CustomTextStyles().smallSubtitle,
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                padding:
                                                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                                child: Text('Adicionar',
                                                    style: CustomTextStyles()
                                                        .smallSubtitle
                                                        .copyWith(
                                                            color:
                                                                Colors.white,fontSize: 14)),
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
                                    MainStances
                                        .plugglyService.getBankAccounts.length,
                                    (index) => BillingItemWidget(
                                        bankAccount: MainStances
                                            .plugglyService.getBankAccounts
                                            .toList()[index]))
                              ],
                            ),
                          ),
                        ),
                        // Conteúdo da Tab 2
                        TransactionsPage(),
                        // Conteúdo da Tab 3
                        ResultsPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
