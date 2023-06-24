import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wallet_manager/controller/login_controller.dart';
import 'package:wallet_manager/data/abstract_preferences_helper.dart';
import 'package:wallet_manager/models/user.dart';

class MockPreferencesHelper extends Mock implements IPreferencesHelper {}

void main() {
  late LoginController loginController;
  late User user;
  late MockPreferencesHelper mockHelper;

  setUp(() {
    user = User(email: 'test@example.com', password: 'password123');
    mockHelper = MockPreferencesHelper();
    loginController = LoginController(user: user, helper: mockHelper);
  });

  test('Valid login credentials should return true', () async {
    const usersJson =
        '[{"email": "test@example.com", "password": "password123"}]';

        when(() => mockHelper.getData(any())).thenAnswer((_) => Future.value(usersJson));

    final result = await loginController.login();

    expect(result, true);
    expect(loginController.message.value, '');
  });

  test('Invalid login credentials should set error message', () async {
    const usersJson =
        '[{"email": "another@example.com", "password": "password123"}]';
    when(() => mockHelper.getData(any())).thenAnswer((_) => Future.value(usersJson));


        await loginController.login();

    expect(loginController.message.value, 'Email or password is not correct');
  });
}
