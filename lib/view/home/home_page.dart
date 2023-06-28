import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pluggy_connect/flutter_pluggy_connect.dart';
import 'package:wallet_manager/shared/main_stances.dart';
import 'package:wallet_manager/view/home/loadingPage.dart';
import 'package:wallet_manager/view/home/widgets/billing_item_widget.dart';
import 'package:wallet_manager/view/home/widgets/category_item.dart';
import 'package:wallet_manager/view/home/widgets/last_billing_grid_item.dart';
import 'package:wallet_manager/view/home/widgets/middle_info.dart';
import 'package:wallet_manager/view/home/widgets/percentage_related.dart';
import 'package:wallet_manager/view/home/widgets/perfil.dart';
import '../styles/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showPlugglyConnect = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              showPlugglyConnect = true;
            });
          },
          child: const Icon(Icons.add),
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
              return SingleChildScrollView(
                child: Wrap(
                  runSpacing: 20,
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
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                                4,
                                    (index) => const CategoryItem())
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Minhas Contas',
                            style: CustomTextStyles().smallTitle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    const MiddleInfo(),
                    LestBillingGridItem(),
                    PercentageRelated(),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
