import '../../domain/entities/register.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.password,
    required super.companyName,
    required super.vatNumber,
    required super.streetOne,
    required super.streetTwo,
    required super.city,
    required super.state,
    required super.zip,
    required super.country,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> jsonMap) {
    return RegisterModel(
      firstName: jsonMap['firstName'] as String,
      lastName: jsonMap['lastName'] as String,
      email: jsonMap['email'] as String,
      phoneNumber: jsonMap['phoneNumber'] as String,
      password: jsonMap['password'] as String,
      companyName: jsonMap['companyName'] as String,
      vatNumber: jsonMap['vatNumber'] as String,
      streetOne: jsonMap['streetOne'] as String,
      streetTwo: jsonMap['streetTwo'] as String,
      city: jsonMap['city'] as String,
      state: jsonMap['state'] as String,
      zip: jsonMap['zip'] as String,
      country: jsonMap['country'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'companyName': companyName,
      'vatNumber': vatNumber,
      'streetOne': streetOne,
      'streetTwo': streetTwo,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
    };
  }

  factory RegisterModel.fromEntity(RegisterEntity registerEntity) {
    return RegisterModel(
      firstName: registerEntity.firstName,
      lastName: registerEntity.lastName,
      email: registerEntity.email,
      phoneNumber: registerEntity.phoneNumber,
      password: registerEntity.password,
      companyName: registerEntity.companyName,
      vatNumber: registerEntity.vatNumber,
      streetOne: registerEntity.streetOne,
      streetTwo: registerEntity.streetTwo,
      city: registerEntity.city,
      state: registerEntity.state,
      zip: registerEntity.zip,
      country: registerEntity.country,
    );
  }
}
