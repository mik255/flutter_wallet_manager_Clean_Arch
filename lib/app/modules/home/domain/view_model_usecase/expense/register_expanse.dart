import 'package:wallet_manager/app/modules/home/domain/models/expense.dart';
import 'package:wallet_manager/app/modules/home/domain/view_model_usecase/expense/get_expense_list.dart';

import '../../../../stateManager/bindHandler.dart';
import '../../repositories/expanse_repository.dart';
import '../../state/home_view_model.dart';

class SaveExpanseViewModelUseCase {
  final ExpanseRepository repository;
  final ViewBindingBase<HomeState> bind;

  SaveExpanseViewModelUseCase(
    this.repository,
    this.bind,
  );

  Future<void> call(Expense expense) async {
    try {
      bind.setState(HomeLoadingState());
      await repository.saveExpenseAccount(expense);
      await GetExpanseListViewModelUseCase(repository, bind).call();
    } catch (e) {
      bind.setState(HomeErrorState(message: e.toString()));
    }
  }
}
