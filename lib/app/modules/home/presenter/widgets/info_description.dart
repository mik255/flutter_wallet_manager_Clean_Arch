import 'package:flutter/material.dart';

class InfoDescriptionWidget extends StatelessWidget {
  const InfoDescriptionWidget({
    super.key,
    required this.title,
    required this.description,
    required this.rightWidget,
  });

  final String title;
  final String description;
  final Widget rightWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF0C1425),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            rightWidget,
          ],
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 206,
          child: Text(
            description,
            style: const TextStyle(
              color: Color(0x750C1425),
              fontSize: 10,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
