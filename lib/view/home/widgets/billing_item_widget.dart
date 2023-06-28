import 'package:flutter/material.dart';
import 'package:wallet_manager/shared/extensions/current_formate.dart';

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
      decoration: const BoxDecoration(
        color: Color(0xC3E6E9F1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
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
            Column(
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
            )
          ],
        ),
      ),
    );
  }
}
