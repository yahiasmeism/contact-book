import 'package:contact_book/features/company/data/models/company_model.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final CompanyModel? companyModel;
  const UserModel(
      {required super.id,
      required super.userName,
      required super.normalizedUserName,
      required super.email,
      required super.normalizedEmail,
      required super.emailConfirmed,
      required super.passwordHash,
      required super.securityStamp,
      required super.concurrencyStamp,
      required super.phoneNumber,
      required super.phoneNumberConfirmed,
      required super.twoFactorEnabled,
      super.lockoutEnd,
      required super.lockoutEnabled,
      required super.accessFailedCount,
      required super.firstName,
      required super.lastName,
      required super.status,
      required super.role,
      super.companyId,
      this.companyModel})
      : super(company: companyModel);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        userName: json['userName'] as String,
        normalizedUserName: json['normalizedUserName'] as String,
        email: json['email'] as String,
        normalizedEmail: json['normalizedEmail'] as String,
        emailConfirmed: json['emailConfirmed'] as bool,
        passwordHash: json['passwordHash'] as String,
        securityStamp: json['securityStamp'] as String,
        concurrencyStamp: json['concurrencyStamp'] as String,
        phoneNumber: json['phoneNumber'] as String,
        phoneNumberConfirmed: json['phoneNumberConfirmed'] as bool,
        twoFactorEnabled: json['twoFactorEnabled'] as bool,
        lockoutEnd: json['lockoutEnd'] == null
            ? null
            : DateTime.parse(json['lockoutEnd'] as String),
        lockoutEnabled: json['lockoutEnabled'] as bool,
        accessFailedCount: json['accessFailedCount'] as int,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        status: json['status'] as String,
        role: json['role'] as String,
        companyId: json['companyId'] as int?,
        companyModel: json['company'] == null
            ? null
            : CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'normalizedUserName': normalizedUserName,
        'email': email,
        'normalizedEmail': normalizedEmail,
        'emailConfirmed': emailConfirmed,
        'passwordHash': passwordHash,
        'securityStamp': securityStamp,
        'concurrencyStamp': concurrencyStamp,
        'phoneNumber': phoneNumber,
        'phoneNumberConfirmed': phoneNumberConfirmed,
        'twoFactorEnabled': twoFactorEnabled,
        'lockoutEnd': lockoutEnd?.toIso8601String(),
        'lockoutEnabled': lockoutEnabled,
        'accessFailedCount': accessFailedCount,
        'firstName': firstName,
        'lastName': lastName,
        'status': status,
        'role': role,
        'companyId': companyId,
        'company': companyModel?.toJson(),
      };
}
