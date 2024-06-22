// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarInfoAdapter extends TypeAdapter<CarInfo> {
  @override
  final int typeId = 0;

  @override
  CarInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarInfo(
      id: fields[0] as String,
      carName: fields[1] as String,
      odo: fields[2] as int,
      mpg: fields[3] as double,
      lastFuel: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CarInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.carName)
      ..writeByte(2)
      ..write(obj.odo)
      ..writeByte(3)
      ..write(obj.mpg)
      ..writeByte(4)
      ..write(obj.lastFuel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
