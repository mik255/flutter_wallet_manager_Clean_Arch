import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/modules/account/data/repositories/auth/auth_impl.dart';
import '../../../shared/navigator/route_impl.dart';
import '../domain/interactors/auth_view_model/auth_view_model.dart';
import '../infra/datasources/auth/google_login_impl.dart';
import '../states/auth_with_velueNotifie.dart';
import 'login_page.dart';

class LoginBuild extends StatelessWidget {
  const LoginBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<AuthViewModel>(
        create: (_) => AuthViewModel(
          repository: AuthImpl(
            authDataSource: GoogleLoginServiceImpl(),
          ),
          state: AuthStateImpl(),
          routes: RouteImpl(
            context: context,
          ),
        ),
      ),
    ], child: const LoginPage());
  }
}
