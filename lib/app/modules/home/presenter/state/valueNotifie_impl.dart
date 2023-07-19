import 'package:flutter/cupertino.dart';
import '../../domain/state/home_view_model.dart';

class HomeStateImpl extends ValueNotifier<HomeState> implements HomeState {
  HomeStateImpl() : super(HomeLoadingState());

  @override
  void setState(HomeState state) {
    value = state;
  }

   @override
   onListenerBuilder(
     Function(HomeState state) builder,
  ) {
    return AnimatedBuilder(
        animation: this,
        builder: (context, _) {
          return builder(value);
        });
  }
}
