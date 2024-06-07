// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyEntityAdapter extends TypeAdapter<CompanyEntity> {
  @override
  final int typeId = 0;

  @override
  CompanyEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyEntity(
      id: fields[0] as int,
      companyName: fields[1] as String,
      vatNumber: fields[2] as String,
      streetOne: fields[3] as String,
      streetTwo: fields[4] as String?,
      city: fields[5] as String,
      state: fields[6] as String,
      zip: fields[7] as String,
      country: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.vatNumber)
      ..writeByte(3)
      ..write(obj.streetOne)
      ..writeByte(4)
      ..write(obj.streetTwo)
      ..writeByte(5)
      ..write(obj.city)
      ..writeByte(6)
      ..write(obj.state)
      ..writeByte(7)
      ..write(obj.zip)
      ..writeByte(8)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
