import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../styles/container_decorators.dart';
import '../../../account/domain/interactors/auth_view_model/auth_view_model.dart';
import '../../../account/domain/states/auth_states.dart';
import '../../domain/viewmodels/home_view_model.dart';



class PerfilWidget extends StatelessWidget {
  const PerfilWidget({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    AuthViewModel viewModel = Provider.of<AuthViewModel>(context);
    return  Container(
      color: const Color(0x42D9D9D9),
      height: 56,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
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
                    AuthState.currentUser.photoUrl ??
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
              AuthState.currentUser.name ?? '',
              style: const TextStyle(
                color: Color(0x960C1425),
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            InkWell(
                onTap: () {
                 // homeViewModel.openFinanceService.updateAllItem();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Scaffold(
                  //                 body: AnimatedBuilder(
                  //               animation:
                  //               (homeViewModel.openFinanceService as PlugglyService).loadingUpdating,
                  //               builder: (context, child) {
                  //                 if ((homeViewModel.openFinanceService as PlugglyService).loadingUpdating.value) {
                  //                   return Scaffold(
                  //                     backgroundColor: Colors.white,
                  //                     bottomNavigationBar: Container(
                  //                       height: 100,
                  //                       child: const Text(
                  //                         'Atualizando dados... \n pode demorar alguns minutos ',
                  //                         textAlign: TextAlign.center,
                  //                       ),
                  //                     ),
                  //                     body: const Center(
                  //                       child: Column(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: [
                  //                           LottieLoader(
                  //                             animationPath:
                  //                                 'assets/animations/updating.json',
                  //                             fit: BoxFit.cover,
                  //                             loop: true,
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   );
                  //                 } else {
                  //                   return const HomePage(
                  //                     needLoadData: false,
                  //                   );
                  //                 }
                  //               },
                  //             ))));
                },
                child: const Text('atualizar',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ))),
          ],
        )
      ),
    );

  }
}
