
import 'package:wallet_manager/app/modules/home/domain/models/bank_account.dart';

mixin HomeStates{
void onLoading();
void onLoaded(List<BankAccount> banks);
void onError(String message);
}