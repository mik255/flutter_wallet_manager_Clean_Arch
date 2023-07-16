import 'package:shared_preferences/shared_preferences.dart';


class MainStances {

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static late SharedPreferences preferences;
}
