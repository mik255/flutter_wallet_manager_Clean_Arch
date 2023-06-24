import 'dart:convert';

import '../data/abstract_preferences_helper.dart';
import '../models/user.dart';

class LoginController {
  User user;
  IPreferencesHelper helper;

  LoginController({
    required this.user,
    required this.helper,
  });

  login() async{
    String? result = await helper.getData('users');
    if(result != null){
      List<User> users = _fromStringList(result);
      for(int i = 0; i < users.length; i++){
        if(users[i].email == user.email && users[i].password == user.password){
          return true;
        }
      }
    }
  }

  String? validate(){

     if(!user.validateEmail()){
      return 'Invalid Email';
    }
     if(!user.validatePassword()){
      return 'Invalid Password';
    }
     if(user.validateEmail()&&user.validatePassword()){
       return null;
     }
  }
   List<User> _fromStringList(String list) {
    List<String> resultList = jsonDecode(list);
    List<User> users = [];
    for (String item in resultList) {
      Map<String,dynamic> json = jsonDecode(item);
      users.add(User.fromMap(json));
    }
    return users;
  }
}
