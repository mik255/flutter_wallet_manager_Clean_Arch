import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../styles/container_decorators.dart';
import '../../view_models/user_viewmodel.dart';

class PerfilWidget extends StatelessWidget {
  const PerfilWidget({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: 55,
          width: 55,
          decoration: ContainerDecorators().getBoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              height: 70,
              width: 70,
              child: Image.network(
                viewModel.user!.photoUrl ??
                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          viewModel.user!.name ?? '',
          style: const TextStyle(
            color: Color(0x960C1425),
            fontSize: 12,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        InkWell(
            onTap: onTap,
            child: const Text('atualizar',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ))),
      ],
    );
  }
}
