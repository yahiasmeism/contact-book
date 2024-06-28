// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityEntityAdapter extends TypeAdapter<ActivityEntity> {
  @override
  final int typeId = 3;

  @override
  ActivityEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityEntity(
      id: fields[0] as int,
      action: fields[1] as String,
      timestamp: fields[2] as String,
      contact: fields[3] as String,
      by: fields[4] as String,
      companyId: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.action)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.contact)
      ..writeByte(4)
      ..write(obj.by)
      ..writeByte(5)
      ..write(obj.companyId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
