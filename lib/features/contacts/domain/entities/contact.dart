import 'dart:io';

import '../../../company/data/models/company_model.dart';

class ContactEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? emailTwo;
  final String phoneNumber;
  final String? mobileNumber;
  final File? imageUploadFile;
  final String? imageUrl;
  final ContactStatus? status;
  final bool isFavorite;
  final String address;
  final String? addressTwo;
  final CompanyModel companyModel;

  ContactEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.emailTwo,
    required this.phoneNumber,
    required this.mobileNumber,
    required this.imageUploadFile,
    required this.imageUrl,
    required this.status,
    required this.isFavorite,
    required this.address,
    required this.addressTwo,
    required this.companyModel,
  });
}

enum ContactStatus { Inactive, Active }
