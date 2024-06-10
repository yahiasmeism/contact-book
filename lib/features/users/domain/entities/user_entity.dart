import 'package:contact_book/features/company/domain/entities/company_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'user_entity.g.dart';
@HiveType(typeId: 1)
class UserEntity extends HiveObject with EquatableMixin {
  @HiveField(0)
	final String id;
  @HiveField(1)
	final String? userName;
  @HiveField(2)
	final String? normalizedUserName;
  @HiveField(3)
	final String email;
  @HiveField(4)
	final String? normalizedEmail;
  @HiveField(5)
	final bool? emailConfirmed;
  @HiveField(6)
	final String? passwordHash;
  @HiveField(7)
	final String? securityStamp;
  @HiveField(8)
	final String? concurrencyStamp;
  @HiveField(9)
	final String phoneNumber;
  @HiveField(10)
	final bool? phoneNumberConfirmed;
  @HiveField(11)
	final bool? twoFactorEnabled;
  @HiveField(12)
	final DateTime? lockoutEnd;
  @HiveField(13)
	final bool? lockoutEnabled;
  @HiveField(14)
	final int? accessFailedCount;
  @HiveField(15)
	final String firstName;
  @HiveField(16)
	final String lastName;
  @HiveField(17)
	final String status;
  @HiveField(18)
	final String role;
  @HiveField(19)
	final int? companyId;
  @HiveField(20)
	final CompanyEntity? company;

	  UserEntity({
		required this.id, 
		this.userName, 
		this.normalizedUserName, 
		required this.email, 
		 this.normalizedEmail, 
		 this.emailConfirmed, 
		 this.passwordHash, 
		 this.securityStamp, 
		 this.concurrencyStamp, 
		required this.phoneNumber, 
		 this.phoneNumberConfirmed, 
		 this.twoFactorEnabled, 
		this.lockoutEnd, 
		 this.lockoutEnabled, 
		 this.accessFailedCount, 
		required this.firstName, 
		required this.lastName, 
		required this.status, 
		required this.role, 
		this.companyId, 
		this.company, 
	});
	@override
	List<Object?> get props {
		return [
				id,
				userName,
				normalizedUserName,
				email,
				normalizedEmail,
				emailConfirmed,
				passwordHash,
				securityStamp,
				concurrencyStamp,
				phoneNumber,
				phoneNumberConfirmed,
				twoFactorEnabled,
				lockoutEnd,
				lockoutEnabled,
				accessFailedCount,
				firstName,
				lastName,
				status,
				role,
				companyId,
				company,
		];
	}
}
