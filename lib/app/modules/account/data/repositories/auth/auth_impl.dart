import 'package:wallet_manager/app/modules/account/domain/repositories/auth_repository.dart';
import 'package:wallet_manager/app/shared/models/user.dart';

import '../../../infra/datasources/auth/auth_datasource.dart';

class AuthImpl extends AuthRepository {
  AuthDataSource authDataSource;

  AuthImpl({required this.authDataSource});

  @override
  Future<User> singIn() async {
    return await authDataSource.singIn();
  }

  @override
  Future<void> singOut() async {
    return await authDataSource.singOut();
  }
}
