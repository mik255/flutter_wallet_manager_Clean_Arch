import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/app/modules/home/data/repository/local_storange_bank_repo_impl.dart';
import 'package:wallet_manager/app/modules/home/infra/datasources/cache/shaared_preferences/shared_preferences_impl.dart';
import 'package:wallet_manager/app/modules/home/presenter/pages/home_page.dart';
import 'package:wallet_manager/app/modules/home/presenter/state/valueNotifie_impl.dart';
import '../domain/interactors/home_view_model_impl.dart';
import '../domain/viewmodels/home_view_model.dart';


class HomePageBuilder extends StatelessWidget {
  const HomePageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<HomeViewModel>(
            create: (context) => HomeViewModelImpl(
              bankAccountRepository: LocalBankAccountRepositoryImpl(
                  localDataSource: SharedPreferencesImpl()
              ),
              state: HomeStateImpl(),
            ),
          ),

        ],
        child:  const HomePage(needLoadData: false,));
  }
}

