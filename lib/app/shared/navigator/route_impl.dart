import 'package:flutter/cupertino.dart';
import 'package:wallet_manager/app/shared/navigator/routes.dart';

class RouteImpl extends Routes {
  RouteImpl({
    required this.context,
  });

  BuildContext context;

  @override
  navigateTo(String name) {
    Navigator.pushNamed(context, name);
  }
}
