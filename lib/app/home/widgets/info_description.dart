import 'package:flutter/material.dart';

class InfoDescriptionWidget extends StatelessWidget {
  const InfoDescriptionWidget({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF0C1425),
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
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
