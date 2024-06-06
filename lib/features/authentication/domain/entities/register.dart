import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  final String password;
  final String companyName;
  final String vatNumber;
  final String streetOne;
  final String streetTwo;
  final String city;
  final String state;
  final String zip;
  final String country;

  const RegisterEntity(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.companyName,
      required this.vatNumber,
      required this.streetOne,
      required this.streetTwo,
      required this.city,
      required this.state,
      required this.zip,
      required this.country});

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      email,
      phoneNumber,
      password,
      companyName,
      vatNumber,
      streetOne,
      streetTwo,
      city,
      state,
      zip,
      country,
    ];
  }
}
