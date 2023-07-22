import 'package:flutter/cupertino.dart';
import '../../domain/state/home_view_model.dart';

class HomeBindImpl extends ValueNotifier<HomeState> implements HomeViewBinding {
  HomeBindImpl() : super(HomeLoadingState());

  @override
  void setState(HomeState newState) {
    value = newState;
  }
  @override
  HomeState get state => value;

  @override
  onBindListener(
    Function() builder,
  ) {
    return ValueListenableBuilder(
      valueListenable: this,
        builder: (context, state,child) {
          return builder();
        });
  }

}
