import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pluggy_connect/flutter_pluggy_connect.dart';
import 'package:wallet_manager/app/home/pages/transactions_page.dart';
import 'package:wallet_manager/app/home/widgets/billing_item_widget.dart';
import 'package:wallet_manager/app/home/widgets/perfil.dart';
import '../../../main_stances.dart';
import '../../styles/text_styles.dart';
import 'loadingPage.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool showPlugglyConnect = false;
  late TabController _tabController;
  bool menuOpened = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // alignment: FractionalOffset.centerLeft,
            // transform: Matrix4.identity()..scale(-1.0, 1),
            AnimatedContainer(
              alignment: Alignment.bottomRight,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: menuOpened?174:0,
              height: menuOpened?156:0,
              decoration: ShapeDecoration(
                color: const Color(0xFFF5F6F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: menuOpened?FadeTransition(
                opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                  parent: AnimationController(
                    duration: const Duration(milliseconds: 1500),
                    vsync: this,
                  )..forward(),
                  curve: Curves.easeInOut,
                )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      runSpacing: 16,
                      runAlignment: WrapAlignment.center,
                      children: [
                         InkWell(
                           onTap: () {
                             setState(() {
                               showPlugglyConnect = true;
                             });
                           },
                           child: Text(
                            'Instituição financeira',
                            style: CustomTextStyles().smallSubtitle,
                        ),
                         ),
                         Text(
                          'Conta Periódica',
                          style: CustomTextStyles().smallSubtitle,
                        ),
                        Text(
                          'Conta Agendada',
                          style: CustomTextStyles().smallSubtitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ):Container(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 150),
                FloatingActionButton(
                  onPressed: () {
                   setState(() {
                     menuOpened = !menuOpened;
                   });
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
        body: Builder(
            builder: (context) {
              if (showPlugglyConnect) {
                return PluggyConnect(
                  connectToken: MainStances.plugglyService.accessToken,
                  onSuccess: (data) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                       LoadingPage(id: data['item']['id'],)));
                    });

                  },
                  onClose: () {
                    setState(() {
                      showPlugglyConnect = false;
                    });
                  },
                );
              }
              return Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(

                        image: DecorationImage(
                          image: AssetImage('assets/home_background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Column(
                          children: [
                            const PerfilWidget(),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 100,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.8,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 32),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '\$ 3.248,95',
                                        style: CustomTextStyles().title
                                            .copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Minhas Contas'),
                      Tab(text: 'Transações'),
                      Tab(text: 'Estatisticas'),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          // Conteúdo da Tab 1
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...List.generate(
                                      MainStances.plugglyService.getBankAccounts
                                          .length,
                                          (index) =>
                                          BillingItemWidget(
                                              bankAccount: MainStances.plugglyService
                                                  .getBankAccounts.toList()[index]))
                                ],
                              ),
                            ),
                          ),
                          // Conteúdo da Tab 2
                          const Center(child: TransactionsPage()),
                          // Conteúdo da Tab 3
                          Center(child: Text('Conteúdo da Tab 3')),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
