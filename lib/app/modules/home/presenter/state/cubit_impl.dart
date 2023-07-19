import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/state/home_view_model.dart';

class HomeStateCubitImpl extends Cubit<HomeState> implements HomeState {
  HomeStateCubitImpl() : super(HomeLoadingState());

  @override
  void setState(HomeState state) {
    emit(state);
  }

  @override
   onListenerBuilder(
    Function(HomeState state) builder,
  ) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          return builder(snapshot.data??HomeLoadingState());
        });
  }
}
