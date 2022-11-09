// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataModelAdapter extends TypeAdapter<DataModel> {
  @override
  final int typeId = 0;

  @override
  DataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataModel(
      location: fields[4] as String?,
      foto: fields[5] as String?,
      kk: fields[0] as String?,
      nama: fields[1] as String?,
      jumlahKeluarga: fields[2] as int?,
      alamat: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.kk)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.jumlahKeluarga)
      ..writeByte(3)
      ..write(obj.alamat)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.foto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
