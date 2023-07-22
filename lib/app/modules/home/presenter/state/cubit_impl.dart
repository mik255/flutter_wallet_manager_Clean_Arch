import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/state/home_view_model.dart';

class HomeBindCubitImpl extends Cubit<HomeState> implements HomeViewBinding {
  HomeBindCubitImpl() : super(HomeLoadingState());

  @override
  void setState(HomeState value) {
    emit(value);
    state = value;
  }
  @override
  HomeState state = HomeLoadingState();
  @override
   onBindListener(
    Function() builder,
  ) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          return builder();
        });
  }

}
