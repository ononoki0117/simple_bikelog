import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:simple_bikelog/constants/bikelog_colors.dart';
import 'package:simple_bikelog/model/car_info_model.dart';
import 'package:simple_bikelog/model/fuel_info_model.dart';

class FuelHistoryScreen extends StatefulWidget {
  final CarInfo selectedCar;

  const FuelHistoryScreen({super.key, required this.selectedCar});

  @override
  State<StatefulWidget> createState() => _FuelHistoryScreenState();
}

class _FuelHistoryElement extends StatelessWidget {
  final FuelInfo info;

  const _FuelHistoryElement({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 38;

    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: width,
        height: 50,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, -0.03),
            end: Alignment(-1, 0.03),
            colors: [Color(0xFFF6F6F6), Color(0xFFFAFAFA)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: BikeLogColors.shadow,
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
                top: 15,
                left: 10,
                child: Text(
                  "${info.time.year}. ${info.time.month}. ${info.time.day}",
                  style: const TextStyle(
                    color: BikeLogColors.grey,
                    fontSize: 15,
                  ),
                )),
            Positioned(
              top: 15,
              right: 10,
              child: Text(
                "${info.inFuelAmount}l, ${info.odoNow}km",
                style: const TextStyle(
                  color: BikeLogColors.grey,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FuelHistoryScreenState extends State<FuelHistoryScreen> {
  Iterable<FuelInfo> _searchedFuelInfo = [];

  @override
  void initState() {
    for (var element in _searchedFuelInfo) {
      debugPrint(element.id);
    }

    super.initState();
  }

  List<Widget> getItems(CarInfo selectedCar) {
    var fuelInfoList = Hive.box<FuelInfo>('fuelInfo');
    _searchedFuelInfo = fuelInfoList.values
        .where((element) => element.carId.contains(selectedCar.id));

    List<Widget> items = List.empty(growable: true);

    for (var info in _searchedFuelInfo) {
      debugPrint(info.carId);
      items.add(_FuelHistoryElement(info: info));
      items.add(const SizedBox(
        height: 10,
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BikeLogColors.background,

      // appbar
      appBar: AppBar(
        backgroundColor: BikeLogColors.appbar,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
        shadowColor: Colors.black,
        title: const Text(
          '주유 기록',
          style: TextStyle(
            color: BikeLogColors.grey,
            fontSize: 19,
            fontWeight: FontWeight.w400,
          ),
        ),
        iconTheme: const IconThemeData(color: BikeLogColors.grey),
      ),

      body: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: getItems(widget.selectedCar),
            ),
          ),
        ),
      ),
    );
  }
}
