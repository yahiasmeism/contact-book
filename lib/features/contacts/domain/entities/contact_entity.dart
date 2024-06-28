// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:contact_book/features/company/domain/entities/company_entity.dart';

part 'contact_entity.g.dart';

@HiveType(typeId: 2)
class ContactEntity extends Equatable {
  
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String? emailTwo;
  @HiveField(5)
  final String phoneNumber;
  @HiveField(6)
  final String? mobileNumber;
  @HiveField(7)
  final File? imageUploadFile;
  @HiveField(8)
  final String? imageUrl;
  @HiveField(9)
  final String? status;
  @HiveField(10)
  bool? isFavorite;
  @HiveField(11)
  final String address;
  @HiveField(12)
  final String? addressTwo;
  @HiveField(13)
  final int? companyId;
  @HiveField(14)
  final CompanyEntity? company;

   ContactEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.emailTwo,
    required this.phoneNumber,
    this.mobileNumber,
    this.imageUploadFile,
    this.imageUrl,
    this.status,
    this.isFavorite,
    required this.address,
    this.addressTwo,
    this.companyId,
    this.company,
  });

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      emailTwo,
      phoneNumber,
      mobileNumber,
      imageUploadFile,
      imageUrl,
      status,
      isFavorite,
      address,
      addressTwo,
      companyId,
      company,
    ];
  }

  @override
  String toString() {
    return 'ContactEntity(id: $id, firstName: $firstName, lastName: $lastName, email: $email, emailTwo: $emailTwo, phoneNumber: $phoneNumber, mobileNumber: $mobileNumber, imageUploadFile: $imageUploadFile, imageUrl: $imageUrl, status: $status, isFavorite: $isFavorite, address: $address, addressTwo: $addressTwo, companyId: $companyId, company: $company)';
  }
}
