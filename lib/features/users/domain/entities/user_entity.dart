import 'package:contact_book/features/company/domain/entities/company_entity.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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
	final DateTime? lockoutEnd;
	final bool lockoutEnabled;
	final int accessFailedCount;
	final String firstName;
	final String lastName;
	final String status;
	final String role;
	final int? companyId;
	final CompanyEntity? company;

	const UserEntity({
		required this.id, 
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
		this.lockoutEnd, 
		required this.lockoutEnabled, 
		required this.accessFailedCount, 
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
