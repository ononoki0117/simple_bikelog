// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FuelInfoAdapter extends TypeAdapter<FuelInfo> {
  @override
  final int typeId = 1;

  @override
  FuelInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelInfo(
      id: fields[0] as String,
      inFuelAmount: fields[1] as double,
      time: fields[2] as DateTime,
      odoNow: fields[3] as int,
      carId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FuelInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.inFuelAmount)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.odoNow)
      ..writeByte(4)
      ..write(obj.carId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
