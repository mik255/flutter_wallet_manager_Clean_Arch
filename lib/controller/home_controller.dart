import '../models/billing.dart';
import '../models/item_billing.dart';

class HomeController {


  double getTotal(List<Billing> listBilling) {
    double total = 0;
    for (var element in listBilling) {
      total += element.getTotal();
    }
    return total;
  }
}
