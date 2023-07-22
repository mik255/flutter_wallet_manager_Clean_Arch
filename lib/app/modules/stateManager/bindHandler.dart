import 'package:flutter/cupertino.dart';

abstract class ViewBindingBase<T> {
  T get state;

  void setState(T state);

  Widget onBindListener(
    Widget Function() builder,
  );
}
