import '../../models/bank_account.dart';
import '../../repositories/bank_repository.dart';

class RegisterAccountUsecase {
  BankAccountRepository accountRepository;

  RegisterAccountUsecase({required this.accountRepository});

  Future<void> call(BankAccount bankAccount) async {
    try {
      await accountRepository.saveBankAccount(bankAccount);
    } catch (e) {
      rethrow;
    }
  }
}
