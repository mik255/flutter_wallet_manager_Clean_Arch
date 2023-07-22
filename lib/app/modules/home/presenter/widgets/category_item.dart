import 'package:flutter/material.dart';
import '../../../../styles/container_decorators.dart';
import '../../../../styles/text_styles.dart';


class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 32),
      decoration: ContainerDecorators().getOutLineBorderDecorator(color: Colors.grey),
      child: Center(
        child: Text(
          'Category',
          style: CustomTextStyles().smallTitle.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
