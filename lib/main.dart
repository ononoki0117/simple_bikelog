import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_bikelog/constants/bikelog_colors.dart';
import 'package:simple_bikelog/model/car_info_model.dart';
import 'package:simple_bikelog/model/fuel_info_model.dart';
import 'package:simple_bikelog/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CarInfoAdapter());
  Hive.registerAdapter(FuelInfoAdapter());

  await Hive.openBox<CarInfo>('carInfo');
  await Hive.openBox<FuelInfo>('fuelInfo');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: BikeLogColors.background,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '집에 가고 싶다',
      home: HomeScreen(title: "bikelog"),
    );
  }
}
