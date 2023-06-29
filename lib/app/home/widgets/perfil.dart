import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/login/login_build.dart';
import '../../../infra/services/auth/google_login_impl.dart';
import '../../styles/container_decorators.dart';
import '../../styles/text_styles.dart';
import '../../view_models/user_viewmodel.dart';

class PerfilWidget extends StatelessWidget {
  const PerfilWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: 80,
          width: 80,
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
                viewModel.user!.photoUrl??'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          viewModel.user!.name,
          style: CustomTextStyles().smallTitle.copyWith(color: Colors.black),
        ),
        const Spacer(),
        InkWell(
            onTap: () async {
              await viewModel.singOut(GoogleLoginServiceImpl()).then((value) =>
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginBuild())));
            },
            child: const Text('Sair')),
      ],
    );
  }
}
