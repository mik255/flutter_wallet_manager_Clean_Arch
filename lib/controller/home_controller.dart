import 'dart:convert';

import '../data/abstract_preferences_helper.dart';
import '../models/billing.dart';
import '../models/item_billing.dart';

class HomeController {

  IPreferencesHelper helper;
  HomeController({required this.helper});
  double getTotal(List<Billing> listBilling) {
    double total = 0;
    for (var element in listBilling) {
      total += element.getTotal();
    }
    return total;
  }

  Future<List<Billing>> getList()async {
    var result =  await helper.getData('Billings');
    List<dynamic> list = jsonDecode(result??'[]');
    return list.map((e) => Billing.fromMap(e as Map<String,dynamic>)).toList();
    }
}
