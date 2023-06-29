import 'package:flutter/material.dart';
import 'package:wallet_manager/models/transaction.dart';
import 'package:wallet_manager/util/extensions/current_formate.dart';
import 'package:wallet_manager/util/extensions/formate_date.dart';
import '../../../models/bank_account.dart';
import '../../styles/container_decorators.dart';
import '../../styles/text_styles.dart';

class BillingItemWidget extends StatelessWidget {
  const BillingItemWidget({super.key, required this.bankAccount});

  final BankAccount bankAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 238,
      decoration: ShapeDecoration(
          color: const Color(0xFFF5F6F9),
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
                    child: Image.network(
                      'https://t.ctcdn.com.br/3tQdC0dhzmQcV8uSocwIy8gtyic=/400x400/smart/filters:format(webp)/i624750.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NuBank',
                      style: CustomTextStyles()
                          .smallSubtitle
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'Mikael S Rocha',
                      style: TextStyle(
                        color: Color(0xFF505869),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
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
                  ...bankAccount.balanceTypes.map((e) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${e.balanceType.getName} :',
                            style: const TextStyle(
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
      subtitle = transaction.name.split('-')[1];
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.add_card_outlined,
                        color: Colors.black,
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
                            style: CustomTextStyles()
                                .smallSubtitle
                                .copyWith(fontWeight: FontWeight.w500),
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
                        transaction.amount
                            .abs()
                            .toCurrencyString(withSymbol: false),
                        style: const TextStyle(
                          color: Color(0xFF505869),
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
