
import 'package:flutter/material.dart';

import '../../styles/container_decorators.dart';
import '../../styles/text_styles.dart';

class PerfilWidget extends StatelessWidget {
  const PerfilWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 80,
            width: 80,
            decoration:
            ContainerDecorators().getBoxDecoration(
              color: Colors.white,
            ),
            child: Image.network(
              'https://www.publicbooks.org/wp-content/uploads/2019/11/joel-mott-LaK153ghdig-unsplash-scaled-e1574787737429.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8,),
          Text(
            'Larissa',
            style: CustomTextStyles()
                .smallTitle
                .copyWith(color: Colors.black),
          ),
          const Spacer(),
          const Column(
            children: [
              Text('26/08/2021'),
              Text('Quarta-feira'),
            ],
          )
        ],
      ),
    );
  }
}
