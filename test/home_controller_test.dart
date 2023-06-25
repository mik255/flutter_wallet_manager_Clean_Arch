import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_manager/controller/home_controller.dart';
import 'package:wallet_manager/models/billing.dart';
import 'package:wallet_manager/models/item_billing.dart';

void main() {
  test('load and calculate', () {
    HomeController homeController = HomeController();
    List<Billing> listBilling = [
      Billing(name: 'a1', items: [
        BillingItem(
          name: '',
          price: 10,
          installments: 2,
          category: BillingCategory.food,
        )
      ]),
      Billing(name: 'a1', items: [
        BillingItem(
          name: '',
          price: 10,
          installments: 2,
          category: BillingCategory.food,
        )
      ]),
      Billing(name: 'a1', items: [
        BillingItem(
          name: '',
          price: 10,
          installments: 2,
          category: BillingCategory.food,
        )
      ])
    ];
    expect(homeController.getTotal(listBilling),60);
  });


}
