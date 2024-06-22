import 'package:hive/hive.dart';

part 'car_info_model.g.dart';

@HiveType(typeId: 0)
class CarInfo {
  @HiveField(0)
  String id;

  @HiveField(1)
  String carName;

  @HiveField(2)
  int odo;

  @HiveField(3)
  double mpg;

  @HiveField(4)
  double lastFuel;

  CarInfo({
    required this.id,
    required this.carName,
    required this.odo,
    required this.mpg,
    required this.lastFuel,
  });
}
