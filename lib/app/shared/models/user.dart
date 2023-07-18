class User {
  String email;
  String? password;
  String name;
  String? photoUrl;

  bool validateEmail() {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email.trim());
  }

  bool validatePassword() {
    final passwordRegex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegex.hasMatch(password!.trim());
  }
  String toMapString(){
    return '{email: $email, password: $password, name: $name, photoUrl: $photoUrl}';
  }

  Map<String,dynamic> toMap(){
    return {
      'email': email,
      'password': password,
      'name': name,
      'photoUrl': photoUrl
    };
  }
  User({
    required this.email,
    this.password,
    required this.name,
    this.photoUrl,
  });
}
