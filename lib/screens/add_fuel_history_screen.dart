import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:simple_bikelog/constants/bikelog_colors.dart';
import 'package:simple_bikelog/model/car_info_model.dart';
import 'package:simple_bikelog/model/fuel_info_model.dart';
import 'package:simple_bikelog/screens/home_screen.dart';

class AddNewFuelHistoryScreen extends StatefulWidget {
  final CarInfo selectedCar;

  const AddNewFuelHistoryScreen({super.key, required this.selectedCar});

  @override
  State<StatefulWidget> createState() => _AddNewFuelScreenState();
}

class _AddNewFuelScreenState extends State<AddNewFuelHistoryScreen> {
  late CarInfo selectedCar;

  var fuelInfoList = Hive.box<FuelInfo>('fuelInfo');
  var carInfoList = Hive.box<CarInfo>('carInfo');

  final fuelAmountFieldController = TextEditingController();
  final odoFieldController = TextEditingController();

  FuelInfo _addNewHistoty(CarInfo info, double fuelAmount, int odo) {
    String carId = info.id;
    DateTime time = DateTime.now();
    String id = fuelInfoList.length.toString();

    FuelInfo fuelInfo = FuelInfo(
        id: id,
        inFuelAmount: fuelAmount,
        time: time,
        odoNow: odo,
        carId: carId);

    fuelInfoList.add(fuelInfo);

    return fuelInfo;
  }

  void _modifyCarMpg(CarInfo carInfo, FuelInfo fuelInfo) {
    int currentOdo = carInfo.odo;
    int newOdo = fuelInfo.odoNow;
    int diff = newOdo - currentOdo;
    double fuel = fuelInfo.inFuelAmount;
    double mpg = diff / fuel;
    double lastFuel = fuel;
    carInfo.mpg = mpg;
    carInfo.odo = newOdo;
    carInfo.lastFuel = lastFuel;
    carInfoList.put(carInfo.id, carInfo);
  }

  @override
  void initState() {
    selectedCar = widget.selectedCar;
    odoFieldController.text = selectedCar.odo.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 38;
    final _formKey = GlobalKey<FormState>();

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
          '주유기록 추가',
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
              children: [
                // 패딩
                const SizedBox(
                  height: 19,
                ),

                // 주유량
                SizedBox(
                    width: width,
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('주유량',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -1.20,
                              ))
                        ])),

                // 텍스트 필드
                SizedBox(
                  width: width,
                  child: TextField(
                    controller: fuelAmountFieldController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]|.'))
                    ],
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onSubmitted: (newName) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),

                // 패딩
                const SizedBox(
                  height: 19,
                ),

                // 누적 주행 거리
                SizedBox(
                    width: width,
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('누적주행거리',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -1.20,
                              ))
                        ])),
                // 텍스트 필드
                SizedBox(
                    width: width,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: odoFieldController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number';
                          }
                          final number = int.tryParse(value);
                          if (number == null) {
                            return 'Please enter a valid number';
                          }
                          if (number < selectedCar.odo) {
                            return 'Please enter a number greater than or equal to 10';
                          }
                          return null;
                        },
                        // onSubmitted: (newName) {
                        //   FocusManager.instance.primaryFocus?.unfocus();
                        // },
                      ),
                    )),

                // 패딩
                const SizedBox(
                  height: 19,
                ),

                //save button
                GestureDetector(
                  child: SizedBox(
                    width: 160,
                    height: 60,
                    child: Container(
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(1.00, -0.03),
                          end: Alignment(-1, 0.03),
                          colors: [Color(0xFFF6F6F6), Color(0xFFFAFAFA)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '저장',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    if (fuelAmountFieldController.text.isEmpty ||
                        !_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('필드를 정확히 입력해 주세요!')),
                      );
                      odoFieldController.text = selectedCar.odo.toString();
                    } else {
                      Navigator.pop(context);

                      FuelInfo fuelInfo = _addNewHistoty(
                          selectedCar,
                          double.parse(fuelAmountFieldController.text),
                          int.parse(odoFieldController.text));

                      _modifyCarMpg(selectedCar, fuelInfo);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen(title: 'title', info: selectedCar);
                      }));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
