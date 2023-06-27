

import 'package:flutter/material.dart';

import 'billing_item_widget.dart';

class LestBillingGridItem extends StatelessWidget {
  const LestBillingGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Ultimas Compras',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        ...List.generate(
                            10,
                                (index) => const BillingItemWidget())
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        ...List.generate(
                            10,
                                (index) => const BillingItemWidget())
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
