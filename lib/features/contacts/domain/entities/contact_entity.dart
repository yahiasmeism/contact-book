import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../company/data/models/company_model.dart';

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
  final bool? isFavorite;
  @HiveField(11)
  final String address;
  @HiveField(12)
  final String? addressTwo;
  @HiveField(13)
  final int? companyId;
  @HiveField(14)
  final CompanyModel? companyModel;

  const ContactEntity({
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
    required this.companyId,
    required this.companyModel,
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
      companyModel,
    ];
  }
}
