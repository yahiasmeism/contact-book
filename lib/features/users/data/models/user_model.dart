import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {super.id,
      required super.email,
      required super.phoneNumber,
      required super.firstName,
      required super.lastName,
      required super.role,
      required super.status});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String?,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        status: json['status'] as String?,
        role: json['role'] as String,
      );

  Map<String, dynamic> get toJson => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'status': status,
        'role': role,
      };

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      role: role,
      status: status,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      role: entity.role,
    );
  }
}
