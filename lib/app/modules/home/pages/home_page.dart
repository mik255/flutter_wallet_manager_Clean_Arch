import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/modules/home/pages/results_page.dart';
import 'package:wallet_manager/app/modules/home/pages/transactions_page.dart';
import 'package:wallet_manager/app/shared/state/base_view_listener.dart';
import 'package:wallet_manager/domain/usecases/calculators/financial_results_calculator.dart';
import '../../../shared/widgets/date_rage_piker.dart';
import '../domain/interactors/home/home_load_data.dart';
import '../widgets/perfil.dart';
import '../widgets/values_header_info.dart';
import 'my_accounts.dart';

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
  String currentItemId = '';
  late HomeLoadDataInteractor loadDataInteractor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadDataInteractor = context.read<HomeLoadDataInteractor>();
    loadDataInteractor.loadInitialData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FinancialResultsCalculator financialResultsCalculator = FinancialResultsCalculator();

    return SafeArea(
      child: Scaffold(
        body: StateBindListenerWithListenable(
            states: [loadDataInteractor],
            child: Builder( builder: (context) {
              if (loadDataInteractor.loadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    PerfilWidget(
                      onTap: () async {
                      //  homeviewmodel.updateAllItem();
                      },
                    ),
                    Header(
                      financialResultsCalculator: financialResultsCalculator,
                    )
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Minhas Contas'),
                        Tab(text: 'Transações'),
                        Tab(text: 'Resultados'),
                      ],
                    ),
                    SizedBox(
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
    ));

  }

}
