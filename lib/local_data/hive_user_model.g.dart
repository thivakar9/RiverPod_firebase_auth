// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 0;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      name: fields[0] as String?,
      lang: fields[1] as String?,
      emailId: fields[2] as String?,
      mobileNumber: fields[3] as String?,
      district: fields[6] as String?,
      state: fields[4] as String?,
      city: fields[5] as String?,
      pinCode: fields[7] as String?,
      id: fields[8] as int?
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lang)
      ..writeByte(2)
      ..write(obj.emailId)
      ..writeByte(3)
      ..write(obj.mobileNumber)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.city)
      ..writeByte(6)
      ..write(obj.district)
      ..writeByte(7)
      ..write(obj.pinCode)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
