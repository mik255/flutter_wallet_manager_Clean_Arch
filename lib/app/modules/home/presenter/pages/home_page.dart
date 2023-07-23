import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wallet_manager/app/modules/home/data/repository/expense_repository_impl.dart';
import 'package:wallet_manager/app/modules/home/domain/view_model_usecase/bank_account/get_banks_account.dart';
import 'package:wallet_manager/app/modules/home/domain/view_model_usecase/bank_account/load_initial_data.dart';
import 'package:wallet_manager/app/modules/home/domain/view_model_usecase/expense/get_expense_list.dart';
import 'package:wallet_manager/app/modules/home/presenter/pages/results_page.dart';
import 'package:wallet_manager/app/modules/home/presenter/pages/transactions_page.dart';
import 'package:wallet_manager/app/modules/home/presenter/state/valueNotifie_impl.dart';
import '../../domain/repositories/bank_repository.dart';
import '../../domain/repositories/expanse_repository.dart';
import '../../domain/state/home_view_model.dart';
import '../widgets/header.dart';
import '../widgets/perfil.dart';
import 'expensive_page.dart';
import 'my_accounts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late InitiLoadDataViewModelUseCase loadInitialData;
  var homeBindImpl = GetIt.I<HomeBindImpl>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    var bankAccountRepository = GetIt.I<BankAccountRepository>();
    var expensiveRepository = GetIt.I<ExpanseRepository>();

    loadInitialData = InitiLoadDataViewModelUseCase(
      bankAccountRepository,
      homeBindImpl,
      GetBankAccountListViewModelUseCase(
        bankAccountRepository,
        homeBindImpl,
      ),
      GetExpanseListViewModelUseCase(
        expensiveRepository,
        homeBindImpl,
      ),
    );
    loadInitialData.call();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: homeBindImpl.onBindListener(() {
      if (homeBindImpl.state is HomeLoadingState) {
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
            const Header(),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Minhas Contas'),
                Tab(text: 'Transações'),
                Tab(text: 'Dispesas'),
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
                    MyAccounts(),
                    TransactionsPage(),
                    ExepensivePage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    })));
  }
}
