import 'package:flutter/material.dart';
import 'package:wallet_manager/shared/extensions/current_formate.dart';

class BalanceInfo {
  final String name;
  final double balance;
  final IconData icon;
  final Color color;

  BalanceInfo({
    required this.name,
    required this.balance,
    required this.icon,
    required this.color,
  });
}

class BalanceBoxInfo extends StatelessWidget {
  const BalanceBoxInfo({super.key,required this.balanceInfo});
  final BalanceInfo balanceInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEBEDEF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration:  ShapeDecoration(
              color: balanceInfo.color,
              shape: const OvalBorder(),
            ),
            child: Icon(
              balanceInfo.icon,
              color: Colors.white,
              size: 12,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                balanceInfo.name,
                style: const TextStyle(
                  color: Color(0xFF505869),
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                balanceInfo.balance.toCurrencyString(),
                style:  TextStyle(
                  color: balanceInfo.color,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
