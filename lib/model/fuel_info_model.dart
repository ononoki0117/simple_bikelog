import 'package:hive/hive.dart';

part 'fuel_info_model.g.dart';

@HiveType(typeId: 1)
class FuelInfo {
  @HiveField(0)
  String id;

  @HiveField(1)
  double inFuelAmount;

  @HiveField(2)
  DateTime time;

  @HiveField(3)
  int odoNow;

  @HiveField(4)
  String carId;

  FuelInfo({
    required this.id,
    required this.inFuelAmount,
    required this.time,
    required this.odoNow,
    required this.carId,
  });
}
