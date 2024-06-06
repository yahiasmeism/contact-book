import '../../domain/entities/login.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.email, required super.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginModel.fromEntity(LoginEntity loginEntity) {
    return LoginModel(email: loginEntity.email, password: loginEntity.password);
  }
}
