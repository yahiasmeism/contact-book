import 'dart:io';

import 'package:dio/dio.dart';

import '../../../company/data/models/company_model.dart';
import '../../domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.emailTwo,
    required super.phoneNumber,
    required super.mobileNumber,
    required super.imageUploadFile,
    required super.imageUrl,
    required super.status,
    required super.isFavorite,
    required super.address,
    required super.addressTwo,
    required super.companyId,
    required super.companyModel,
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
      companyModel: json['companyModel'] != null
          ? CompanyModel.fromJson(json['companyModel'])
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
        'company': companyModel?.toJson()
      };

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'emailTwo': emailTwo,
      'phoneNumber': phoneNumber,
      'mobileNumber': mobileNumber,
      'status': status,
      'isFavorite': isFavorite,
      'address': address,
      'addressTwo': addressTwo,
      'company': companyModel?.toJson(),
      if (imageUploadFile != null)
        'imageUploadFile': await MultipartFile.fromFile(imageUploadFile!.path),
    });
  }
}
