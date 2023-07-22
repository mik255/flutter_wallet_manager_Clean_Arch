import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wallet_manager/app/modules/home/presenter/pages/results_page.dart';
import 'package:wallet_manager/app/modules/home/presenter/pages/transactions_page.dart';
import '../../domain/interactors/home_view_model_impl.dart';
import '../../domain/state/home_view_model.dart';
import '../../domain/viewmodels/home_view_model.dart';
import '../widgets/header.dart';
import '../widgets/perfil.dart';
import 'my_accounts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    GetIt.I<HomeViewModelImpl>().loadInitialData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeviewmodel = GetIt.I<HomeViewModelImpl>();

    return SafeArea(child: Scaffold(body: homeviewmodel.bind.onBindListener(() {
      print(homeviewmodel.bind.state);
      if (homeviewmodel.bind.state is HomeLoadingState) {
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
                Tab(text: 'Resultados'),
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
                    ResultsPage(),
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
