import '../../models/bank_account.dart';
import '../../repositories/bank_repository.dart';
import '../instances.dart';


class GetAllAccountUsecase {
  BankAccountRepository accountRepository;

  GetAllAccountUsecase({required this.accountRepository});

  Future<List<BankAccount>> call(bankAccount) async {
    try {
      return currentBankAccounts = await accountRepository.getBankAccounts();
    } catch (e) {
      rethrow;
    }
  }
}
