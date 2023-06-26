class User {
  String email;
  String password;

  User({
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password);

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'User{ email: $email, password: $password,}';
  }

  User copyWith({
    String? email,
    String? password,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  bool validateEmail() {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email.trim());
  }

  bool validatePassword() {
    final passwordRegex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegex.hasMatch(password.trim());
  }
}
