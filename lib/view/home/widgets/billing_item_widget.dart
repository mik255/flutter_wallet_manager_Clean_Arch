

import 'package:flutter/material.dart';

import '../../styles/container_decorators.dart';
import '../../styles/text_styles.dart';

class BillingItemWidget extends StatelessWidget {
  const BillingItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFDDE2EB),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: 50,
              width: 50,
              decoration: ContainerDecorators()
                  .getBoxDecoration(
                color: Colors.white,
              ),
              child: Image.network(
                'https://t.ctcdn.com.br/3tQdC0dhzmQcV8uSocwIy8gtyic=/400x400/smart/filters:format(webp)/i624750.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'NuBank',
                  style: CustomTextStyles()
                      .smallSubtitle
                      .copyWith(
                      fontWeight: FontWeight.w500),
                ),
                Text('\$ 500,00',
                    style: CustomTextStyles()
                        .smallTitle
                        .copyWith(
                        fontWeight:
                        FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
