import 'dart:convert';
import '../domain/models/billing.dart';
import '../infra/abstract_preferences_helper.dart';


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
