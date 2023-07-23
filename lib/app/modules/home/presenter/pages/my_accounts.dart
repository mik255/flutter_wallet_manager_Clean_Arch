import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:wallet_manager/app/modules/home/domain/state/home_view_model.dart';
import 'package:wallet_manager/app/modules/home/presenter/state/valueNotifie_impl.dart';
import '../../../../styles/text_styles.dart';
import '../widgets/billing_item_widget.dart';
import '../widgets/info_description.dart';
import '../widgets/input_and_output_card.dart';
import 'manual_debit_form_register.dart';

class MyAccounts extends StatefulWidget {
    MyAccounts({super.key});

  @override
  State<MyAccounts> createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var homeviewmodel = GetIt.I<HomeBindImpl>();

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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: InputAndOutputCard(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InfoDescriptionWidget(
                    rightWidget: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              _showModel();
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
                            )),
                      ],
                    ),
                    title: 'Contas',
                    description:
                        'Estes valores correspontem ao preiodo de tempo atual de cada conta individualmente',
                  ),
                ],
              ),
              ...List.generate(
                  (homeviewmodel.state as HomeLoadedState).bankAccounts!.length,
                  (index) => BillingItemWidget(
                        bankAccount: (homeviewmodel.state as HomeLoadedState).bankAccounts![index],
                      )),
              Container(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }

  _showModel() {
    return showModalBottomSheet(
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
                      topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AnimateList(
                        interval: 200.ms,
                        effects: [
                          FadeEffect(duration: 150.ms),
                          SlideEffect(
                              delay: 300.ms,
                              duration: 300.ms,
                              curve: Curves.easeInOut,
                              begin: const Offset(0, 0.5),
                              end: Offset.zero)
                        ],
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  ManualDebitFormRegister(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Color(0xFF2D9CDB),
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    'Dispesa manual',
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
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
            ),
          ],
        );
      },
    );
  }
}
