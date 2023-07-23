import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wallet_manager/shared/extensions/current_formate.dart';
import 'package:wallet_manager/shared/extensions/formate_date.dart';
import '../../../../styles/container_decorators.dart';
import '../../../../styles/text_styles.dart';
import '../../domain/state/home_view_model.dart';
import '../state/valueNotifie_impl.dart';
import '../widgets/info_description.dart';
import 'manual_debit_form_register.dart';

class ExepensivePage extends StatelessWidget {
   ExepensivePage({super.key});

  @override
  Widget build(BuildContext context) {
    var homeviewmodel = GetIt.I<HomeBindImpl>();
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InfoDescriptionWidget(
                rightWidget: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManualDebitFormRegister(),
                            ),
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
                            child: Text('Adicionar Despesa',
                                style: CustomTextStyles()
                                    .smallSubtitle
                                    .copyWith(color: Colors.white, fontSize: 14)),
                          ),
                        )),
                  ],
                ),
                title: 'Despesas',
                description:
                    'Estes valores correspontem a todas as dispesas manuais já cadastradas',
              ),
            ],
          ),
          homeviewmodel.onBindListener(() => Column(
            children: [
              ...(homeviewmodel.state as HomeLoadedState).expenses!.map((e)
              =>SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 50,
                            width: 50,
                            decoration: ContainerDecorators().getBoxDecoration(
                              color: Colors.white,
                            ),
                            child: Container(
                                clipBehavior: Clip.antiAlias,
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xC3E6E9F1)),
                                child: const Center(
                                    child: Icon(
                                      Icons.money,
                                      color: Color(0xFF292E38),
                                    ))),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      e.name,
                                      maxLines: 3,
                                      style: CustomTextStyles().smallSubtitle.copyWith(fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Text(
                                      DateTime.parse(e.date).formatDate(),
                                      style: const TextStyle(
                                        color: Color(0xFF505869),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                if (false)
                                  Text(
                                    'subtitle',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFF505869),
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                Text(
                                  e.category,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFF505869),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  e.value.abs().toCurrencyString(withSymbol: false),
                                  style: const TextStyle(
                                    color:  Colors.red,
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black12,
                      )
                    ],
                  ),
                ),
              )).toList()
            ],
          ))
        ],
      ),
    );
  }
}
