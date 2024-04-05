class User {
  final String name;
  final String email;
  final String? password;
  final String? passwordConfirmation;
  final String phone;
  final String birthdate;
  final String gender;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
    required this.birthdate,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] != null ? json['password'] as String : '',
      passwordConfirmation: json['password_confirmation'] != null
          ? json['password_confirmation'] as String
          : '',
      phone: json['phone'] as String,
      birthdate: json['birthdate'] as String,
      gender: json['gender'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'phone': phone,
      'birthdate': birthdate,
      'gender': gender
    };
  }
}
