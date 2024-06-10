// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntityAdapter extends TypeAdapter<UserEntity> {
  @override
  final int typeId = 1;

  @override
  UserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntity(
      id: fields[0] as String,
      userName: fields[1] as String?,
      normalizedUserName: fields[2] as String?,
      email: fields[3] as String,
      normalizedEmail: fields[4] as String?,
      emailConfirmed: fields[5] as bool?,
      passwordHash: fields[6] as String?,
      securityStamp: fields[7] as String?,
      concurrencyStamp: fields[8] as String?,
      phoneNumber: fields[9] as String,
      phoneNumberConfirmed: fields[10] as bool?,
      twoFactorEnabled: fields[11] as bool?,
      lockoutEnd: fields[12] as DateTime?,
      lockoutEnabled: fields[13] as bool?,
      accessFailedCount: fields[14] as int?,
      firstName: fields[15] as String,
      lastName: fields[16] as String,
      status: fields[17] as String,
      role: fields[18] as String,
      companyId: fields[19] as int?,
      company: fields[20] as CompanyEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.normalizedUserName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.normalizedEmail)
      ..writeByte(5)
      ..write(obj.emailConfirmed)
      ..writeByte(6)
      ..write(obj.passwordHash)
      ..writeByte(7)
      ..write(obj.securityStamp)
      ..writeByte(8)
      ..write(obj.concurrencyStamp)
      ..writeByte(9)
      ..write(obj.phoneNumber)
      ..writeByte(10)
      ..write(obj.phoneNumberConfirmed)
      ..writeByte(11)
      ..write(obj.twoFactorEnabled)
      ..writeByte(12)
      ..write(obj.lockoutEnd)
      ..writeByte(13)
      ..write(obj.lockoutEnabled)
      ..writeByte(14)
      ..write(obj.accessFailedCount)
      ..writeByte(15)
      ..write(obj.firstName)
      ..writeByte(16)
      ..write(obj.lastName)
      ..writeByte(17)
      ..write(obj.status)
      ..writeByte(18)
      ..write(obj.role)
      ..writeByte(19)
      ..write(obj.companyId)
      ..writeByte(20)
      ..write(obj.company);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
