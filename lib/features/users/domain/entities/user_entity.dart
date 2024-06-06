import 'package:contact_book/features/company/domain/entities/company_entity.dart';

class UserEntity {
  final String id;
  final String userName;
  final String normalizedUserName;
  final String email;
  final String normalizedEmail;
  final bool emailConfirmed;
  final String passwordHash;
  final String securityStamp;
  final String concurrencyStamp;
  final String phoneNumber;
  final bool phoneNumberConfirmed;
  final bool twoFactorEnabled;
  final String lockoutEnd;
  final bool lockoutEnabled;
  final int accessFailedCount;
  final String firstName;
  final String lastName;
  final String status;
  final String role;
  final int companyId;
  final CompanyEntity? companyEntity;

  UserEntity(
      {required this.id,
      required this.userName,
      required this.normalizedUserName,
      required this.email,
      required this.normalizedEmail,
      required this.emailConfirmed,
      required this.passwordHash,
      required this.securityStamp,
      required this.concurrencyStamp,
      required this.phoneNumber,
      required this.phoneNumberConfirmed,
      required this.twoFactorEnabled,
      required this.lockoutEnd,
      required this.lockoutEnabled,
      required this.accessFailedCount,
      required this.firstName,
      required this.lastName,
      required this.status,
      required this.role,
      required this.companyId,
      required this.companyEntity});
}
