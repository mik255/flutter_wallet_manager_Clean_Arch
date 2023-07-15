import 'package:flutter/material.dart';
import 'package:flutter_pluggy_connect/flutter_pluggy_connect.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/home/pages/my_accounts.dart';
import 'package:wallet_manager/app/home/pages/results_page.dart';
import 'package:wallet_manager/app/home/pages/transactions_page.dart';
import 'package:wallet_manager/app/home/widgets/perfil.dart';
import 'package:wallet_manager/domain/models/financial_results_calculator.dart';
import 'package:wallet_manager/infra/services/financial_data_helper/pluggly/pluggly_impl.dart';
import '../../../main_stances.dart';
import '../../shared/widgets/date_rage_piker.dart';
import '../home_view_model.dart';
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
  late HomeViewModel homeviewmodel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    homeviewmodel = context.read<HomeViewModel>();
    homeviewmodel.loadInitialData();
  }

  getNewAccount() async {
    setState(() {
      loading = true;
    });
    await MainStances.openFinanceService.getAccount(currentItemId);
    setState(() {
      showPlugglyConnect = false;
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
    FinancialResultsCalculator financialResultsCalculator = FinancialResultsCalculator(
      allBanks: MainStances.openFinanceService.getBankAccounts.toList(),
    );

    return SafeArea(
      child: Scaffold(
        body: AnimatedBuilder(
            animation: homeviewmodel.loading,
            builder: (context, _) {
              if (loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (showPlugglyConnect) {
                return PluggyConnect(
                  connectToken: (MainStances.openFinanceService as PlugglyService).accessToken,
                  onSuccess: (data) {
                    currentItemId = data['item']['id'];
                    getNewAccount();
                  },
                  onClose: () {
                    getNewAccount();
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
                            await MainStances.openFinanceService.updateAllItem();
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
                                        initialDate:
                                            (MainStances.openFinanceService as PlugglyService)
                                                .dataRange,
                                        onDateSelected: (date) async {
                                          setState(() {
                                            loading = true;
                                          });
                                          await MainStances.openFinanceService
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            MyAccounts(
                              financialResultsCalculator: financialResultsCalculator,
                              onAddAccount: () {
                                setState(() {
                                  showPlugglyConnect = true;
                                  menuOpened = false;
                                });
                                Navigator.pop(context);
                              },
                            ),
                            const TransactionsPage(),
                            const ResultsPage(),
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
