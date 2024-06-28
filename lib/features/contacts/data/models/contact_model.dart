// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dio/dio.dart';

import '../../../company/data/models/company_model.dart';
import '../../domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    super.emailTwo,
    required super.phoneNumber,
    super.mobileNumber,
    super.imageUploadFile,
    super.imageUrl,
    super.status,
    super.isFavorite,
    required super.address,
    super.addressTwo,
    super.companyId,
    super.company,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as int?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      emailTwo: json['emailTwo'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      mobileNumber: json['mobileNumber'] as String?,
      imageUploadFile: json['imageUploadFile'] != null
          ? File(json['imageUploadFile'])
          : null,
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] as String?,
      isFavorite: json['isFavorite'] as bool?,
      address: json['address'] as String,
      addressTwo: json['addressTwo'] as String?,
      companyId: json['companyId'] as int?,
      company: json['company'] != null
          ? CompanyModel.fromJson(json['company'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'imageUploadFile': imageUploadFile,
        'imageUrl': imageUrl,
        'email': email,
        'emailTwo': emailTwo,
        'phoneNumber': phoneNumber,
        'mobileNumber': mobileNumber,
        'status': status,
        'isFavorite': isFavorite,
        'address': address,
        'addressTwo': addressTwo,
        'companyId': companyId,
        'company': company != null ? CompanyModel.fromEntity(company!) : null,
      };

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'firstName': firstName,
      'lastName': lastName,
      'status': status,
      'email': email,
      'emailTwo': emailTwo,
      'phoneNumber': phoneNumber,
      'mobileNumber': mobileNumber,
      'address': address,
      'addressTwo': addressTwo,
      'companyId': companyId,
      'company': company != null ? CompanyModel.fromEntity(company!) : null,
      if (imageUploadFile != null)
        'imageUploadFile': await MultipartFile.fromFile(imageUploadFile!.path),
    });
  }

  factory ContactModel.fromEntity(ContactEntity contactEntity) {
    return ContactModel(
      id: contactEntity.id,
      firstName: contactEntity.firstName,
      lastName: contactEntity.lastName,
      email: contactEntity.email,
      emailTwo: contactEntity.emailTwo,
      phoneNumber: contactEntity.phoneNumber,
      mobileNumber: contactEntity.mobileNumber,
      imageUploadFile: contactEntity.imageUploadFile,
      imageUrl: contactEntity.imageUrl,
      status: contactEntity.status,
      isFavorite: contactEntity.isFavorite,
      address: contactEntity.address,
      addressTwo: contactEntity.addressTwo,
      companyId: contactEntity.companyId,
      company: contactEntity.company,
    );
  }

  ContactEntity toEntity() {
    return ContactEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      emailTwo: emailTwo,
      phoneNumber: phoneNumber,
      mobileNumber: mobileNumber,
      imageUploadFile: imageUploadFile,
      imageUrl: imageUrl,
      status: status,
      isFavorite: isFavorite,
      address: address,
      addressTwo: addressTwo,
      companyId: companyId,
      company: company,
    );
  }
}
