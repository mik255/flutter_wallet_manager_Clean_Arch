import 'package:flutter/material.dart';
import 'package:wallet_manager/app/modules/home/presenter/widgets/values_header_info.dart';

import '../../../../shared/widgets/date_rage_piker.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: ValuesHeaderInfo(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DateRangePickerWidget(
                        initialDate: DateTimeRange(
                          start: DateTime.now(),
                          end: DateTime.now(),
                        ),
                        onDateSelected: (date) async {
                          //homeviewmodel.updateTransactionsByRange(date);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
