import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_manager/shared/extensions/current_formate.dart';
import 'package:wallet_manager/shared/extensions/formate_date.dart';

import '../../../../styles/container_decorators.dart';
import '../../../../styles/text_styles.dart';
import '../../domain/models/balance_type.dart';
import '../../domain/models/bank_account.dart';
import '../../domain/models/transaction.dart';

class BillingItemWidget extends StatelessWidget {
  const BillingItemWidget({super.key, required this.bankAccount});

  final BankAccount bankAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: SvgPicture.network(
                        height: 40,
                        width: 40,
                        semanticsLabel: 'A shark?!',
                        placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(30.0),
                            child: const CircularProgressIndicator()),
                        'https://svgsilh.com/svg/1801287.svg', // resolver logo
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bankAccount.name,
                          style: CustomTextStyles().smallSubtitle.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          bankAccount.owner,
                          style: const TextStyle(
                            color: Color(0xFF505869),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 32),
                    Container(
                      width: 200,
                      child: const Text(
                        'Esses valores correspondem ao período de tempo atual.',
                        style: TextStyle(
                          color: Color(0x98505869),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...bankAccount.balanceTypes.map((e) => Column(
                        children: [
                          if (e.balanceType == BalanceTypeEnum.CREDIT_CARD)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Fechamento da fatura :',
                                  style: TextStyle(
                                    color: Color(0xFF505869),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'dia ${DateTime.parse(e.balanceCloseDate!).day}',
                                  style: const TextStyle(
                                    color: Color(0xFF0C1425),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          if (e.balanceType == BalanceTypeEnum.CREDIT_CARD)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Vencimento da fatura :',
                                  style: TextStyle(
                                    color: Color(0xFF505869),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'dia ${DateTime.parse(e.balanceDueDate!).day}',
                                  style: const TextStyle(
                                    color: Color(0xFF0C1425),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          if (e.balanceType == BalanceTypeEnum.CHECKING_ACCOUNT)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Saldo em conta :',
                                  style: TextStyle(
                                    color: Color(0xFF505869),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  e.balance.toCurrencyString(withSymbol: false),
                                  style: const TextStyle(
                                    color: Color(0xFF0C1425),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          if (e.balanceType == BalanceTypeEnum.SAVINGS_ACCOUNT)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Saldo em poupança :',
                                  style: TextStyle(
                                    color: Color(0xFF505869),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  100.0.toCurrencyString(withSymbol: false),
                                  style: const TextStyle(
                                    color: Color(0xFF0C1425),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          if (e.balanceType == BalanceTypeEnum.CREDIT_CARD)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Crédito consumido :',
                                        style: TextStyle(
                                          color: Color(0xFF505869),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        e.balance.toDouble().toCurrencyString(withSymbol: false),
                                        style: const TextStyle(
                                          color: Color(0xFF0C1425),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Limite :',
                                        style: TextStyle(
                                          color: Color(0xFF505869),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        e.limit!.toDouble().toCurrencyString(withSymbol: false),
                                        style: const TextStyle(
                                          color: Color(0xFF0C1425),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BillingItemTransactions extends StatelessWidget {
  const BillingItemTransactions({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    String title = transaction.name;
    String subtitle = '';
    try {
      title = transaction.name.split('-')[0];
      subtitle = transaction.name.split('-')[1].trimLeft();
    } catch (e) {}

    return SizedBox(
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
                      child: Center(
                          child: Icon(
                        transaction.category.icon,
                        color: const Color(0xFF292E38),
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
                            title,
                            maxLines: 3,
                            style: CustomTextStyles().smallSubtitle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            DateTime.parse(transaction.date).formatDate(),
                            style: const TextStyle(
                              color: Color(0xFF505869),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      if (subtitle.isNotEmpty)
                        Text(
                          subtitle,
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
                        transaction.category.category,
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
                        transaction.amount.abs().toCurrencyString(withSymbol: false),
                        style: TextStyle(
                          color: transaction.amount > 0 || transaction.type == TransactionType.CREDIT ? Colors.green : Colors.red,
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
    );
  }
}
