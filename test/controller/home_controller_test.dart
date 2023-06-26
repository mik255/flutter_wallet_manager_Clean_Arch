import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wallet_manager/controller/home_controller.dart';
import 'package:wallet_manager/data/abstract_preferences_helper.dart';
String jsonData = '''
[
  {
    "name": "a1",
    "items": [
      {
        "name": "",
        "price": 10,
        "installments": 2,
        "category": "food"
      }
    ]
  },
  {
    "name": "a1",
    "items": [
      {
        "name": "",
        "price": 10,
        "installments": 2,
        "category": "food"
      }
    ]
  },
  {
    "name": "a1",
    "items": [
      {
        "name": "",
        "price": 10,
        "installments": 2,
        "category": "food"
      }
    ]
  }
]
''';
class MockPreferencesHelper extends Mock implements IPreferencesHelper {}
void main() {
  late HomeController homeController;
  late MockPreferencesHelper mockHelper;

  setUp(() {
    mockHelper = MockPreferencesHelper();
    homeController = HomeController(helper: mockHelper);
  });
  test('load and calculate', () async{

    when(() => mockHelper.getData(any())).thenAnswer((_) => Future.value(jsonData));
    var result = await homeController.getList();
    expect(homeController.getTotal(result),60);
  });


}
