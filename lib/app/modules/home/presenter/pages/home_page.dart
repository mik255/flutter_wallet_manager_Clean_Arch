import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';
import 'package:wallet_manager/app/modules/results/presenter/pages/results_page.dart';
import 'package:wallet_manager/app/modules/transactions/presenter/pages/transactions_page.dart';
import '../../domain/state/home_state.dart';
import '../../domain/usecase/bank_account/get_banks_account.dart';
import '../widgets/header.dart';
import '../widgets/perfil.dart';
import 'my_accounts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, HomeStates {
  late TabController _tabController;
  late GetBankAccountListViewModelUseCase getBankAccountListViewModelUseCase;
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<List<BankAccount>> _banks = BehaviorSubject<List<BankAccount>>.seeded([]);
  final BehaviorSubject<bool> _isError = BehaviorSubject<bool>.seeded(false);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    var getBankAccountListViewModelUseCase = GetIt.I<GetBankAccountListViewModelUseCase>();
    getBankAccountListViewModelUseCase.homeStates = this;
    getBankAccountListViewModelUseCase.call();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder(
                stream: Stream.fromIterable([
                  _isLoading.value,
                  _banks.value,
                  _isError.value,
                ]),
                builder: (context, snapshot) {
                  if (_isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (_isError.value) {
                    return const Center(
                      child: Text('Erro ao carregar dados'),
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
                        const Header(),
                        TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          tabs: const [
                            Tab(text: 'Transações'),
                            Tab(text: 'Meus Resultados'),
                            Tab(text: 'Minhas Contas'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 16,
                            ),
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                TransactionsPage(),
                                ResultsPage(),
                                MyAccounts(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })));
  }

  @override
  void onError(String message) {
    _isError.add(true);
  }

  @override
  void onLoaded(List<BankAccount> banks) {
    _banks.add(banks);
    _isLoading.add(false);
  }

  @override
  void onLoading() {
    _isLoading.add(true);
  }
}
