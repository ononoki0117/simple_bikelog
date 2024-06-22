import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:simple_bikelog/constants/bikelog_colors.dart';
import 'package:simple_bikelog/model/car_info_model.dart';
import 'package:simple_bikelog/screens/home_screen.dart';

class AddNewCarScreen extends StatefulWidget {
  final String title;
  const AddNewCarScreen({super.key, required this.title});

  @override
  State<AddNewCarScreen> createState() => _AddNewCarScreenState();
}

class _AddNewCarScreenState extends State<AddNewCarScreen> {
  late final String title;

  late String carName;
  late int carOdo;
  late CarInfo selectedCar;

  var carInfoList = Hive.box<CarInfo>('carInfo');

  final nameFieldController = TextEditingController();
  final odoFieldController = TextEditingController();

  @override
  void initState() {
    title = widget.title;

    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  void _addNewCar(String name, int odo) {
    String id;
    if (carInfoList.values.isEmpty) {
      id = '0';
    } else {
      id = (int.parse(carInfoList.values.last.id) + 1).toString();
    }
    double mpg = 0;
    double lastFuel = 0;
    selectedCar =
        CarInfo(id: id, carName: name, odo: odo, mpg: mpg, lastFuel: lastFuel);
    carInfoList.put(id, selectedCar);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 38;

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
        title: Text(
          title,
          style: const TextStyle(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 19,
                ),

                // 차량 이름
                SizedBox(
                    width: width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '차량 이름',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -1.20,
                          ),
                        ),
                      ],
                    )),

                // 이름 텍스트 필드
                SizedBox(
                  width: width,
                  child: TextField(
                    controller: nameFieldController,
                    onTapOutside: (event) {
                      String name = nameFieldController.text;
                      carName = name;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onSubmitted: (name) {
                      carName = name;
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),

                const SizedBox(
                  height: 19,
                ),

                // 주행거리
                SizedBox(
                    width: width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '현재 누적 주행 거리',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -1.20,
                          ),
                        ),
                      ],
                    )),

                // 주행거리 텍스트 필드
                SizedBox(
                  width: width,
                  child: TextField(
                    controller: odoFieldController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    onTapOutside: (event) {
                      String odo = odoFieldController.text;
                      carOdo = int.parse(odo);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onSubmitted: (odo) {
                      carOdo = int.parse(odo);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),

                // padding
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
                    if (nameFieldController.text.isEmpty ||
                        odoFieldController.text.isEmpty) {
                      debugPrint('값 없');
                    } else {
                      _addNewCar(nameFieldController.text,
                          int.parse(odoFieldController.text));
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen(
                          title: 'title',
                          info: selectedCar,
                        );
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
