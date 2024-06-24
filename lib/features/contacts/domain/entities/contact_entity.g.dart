// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactEntityAdapter extends TypeAdapter<ContactEntity> {
  @override
  final int typeId = 2;

  @override
  ContactEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactEntity(
      id: fields[0] as int?,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      emailTwo: fields[4] as String?,
      phoneNumber: fields[5] as String,
      mobileNumber: fields[6] as String?,
      imageUploadFile: fields[7] as File?,
      imageUrl: fields[8] as String?,
      status: fields[9] as String?,
      isFavorite: fields[10] as bool?,
      address: fields[11] as String,
      addressTwo: fields[12] as String?,
      companyId: fields[13] as int?,
      companyModel: fields[14] as CompanyModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ContactEntity obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.emailTwo)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.mobileNumber)
      ..writeByte(7)
      ..write(obj.imageUploadFile)
      ..writeByte(8)
      ..write(obj.imageUrl)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.isFavorite)
      ..writeByte(11)
      ..write(obj.address)
      ..writeByte(12)
      ..write(obj.addressTwo)
      ..writeByte(13)
      ..write(obj.companyId)
      ..writeByte(14)
      ..write(obj.companyModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
