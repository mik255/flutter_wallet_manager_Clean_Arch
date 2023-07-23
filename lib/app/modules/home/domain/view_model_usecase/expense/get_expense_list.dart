import '../../../../stateManager/bindHandler.dart';
import '../../repositories/expanse_repository.dart';
import '../../state/home_view_model.dart';

class GetExpanseListViewModelUseCase {
  final ExpanseRepository repository;
  final ViewBindingBase<HomeState> bind;

  GetExpanseListViewModelUseCase(
    this.repository,
    this.bind,
  );

  Future<void> call() async {
    try {
      bind.setState(HomeLoadingState());
      var expenses = await repository.getExpenseList();
      bind.setState(homeLoadedState.copyWith(
        expenses: expenses,
      ));
    } catch (e) {
      bind.setState(HomeErrorState(
        message: e.toString(),
      ));
    }
  }
}
