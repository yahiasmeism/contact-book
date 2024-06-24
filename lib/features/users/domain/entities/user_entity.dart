import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'user_entity.g.dart';

@HiveType(typeId: 1)
class UserEntity extends HiveObject with EquatableMixin {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phoneNumber;
  @HiveField(5)
  final String? status;
  @HiveField(6)
  final String role;

  UserEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.status,
    required this.role,
  });
  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      phoneNumber,
      status,
      role,
    ];
  }

  @override
  bool get stringify => true;
}
