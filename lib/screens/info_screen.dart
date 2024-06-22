import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:simple_bikelog/components/appbar_goback_button.dart';
import 'package:simple_bikelog/constants/bikelog_colors.dart';
import 'package:simple_bikelog/model/car_info_model.dart';
import 'package:simple_bikelog/model/fuel_info_model.dart';
import 'package:simple_bikelog/screens/home_screen.dart';

class InfoScreen extends StatefulWidget {
  final String title;
  final CarInfo selectedCar;
  const InfoScreen({super.key, required this.title, required this.selectedCar});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final String title;
  late CarInfo selectedCar;

  var carInfoList = Hive.box<CarInfo>('carInfo');
  var fuelInfoList = Hive.box<FuelInfo>('fuelInfo');

  final nameFieldController = TextEditingController();
  final odoFieldController = TextEditingController();

  @override
  void initState() {
    title = widget.title;

    selectedCar = widget.selectedCar;

    super.initState();
  }

  void _modifyCarName(String carName, CarInfo info) {
    setState(() {
      info.carName = carName;
      carInfoList.put(info.id, info);
    });
  }

  void _modifyOdo(String odo, CarInfo info) {
    setState(() {
      info.odo = int.parse(odo);
      carInfoList.put(info.id, info);
    });
  }

  void _deleteInfo(CarInfo info) {
    setState(() => carInfoList.delete(info.id));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 38;

    nameFieldController.text = selectedCar.carName;
    odoFieldController.text = selectedCar.odo.toString();

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
        leading: const AppbarGobackButton(),
      ),

      body: Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 패딩
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

                // 텍스트 필드
                SizedBox(
                  width: width,
                  child: TextField(
                    controller: nameFieldController,
                    onTapOutside: (event) {
                      String newName = nameFieldController.text;
                      debugPrint(newName);

                      _modifyCarName(newName, selectedCar);

                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onSubmitted: (newName) {
                      _modifyCarName(newName, selectedCar);

                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),

                // 패딩
                const SizedBox(
                  height: 19,
                ),

                // 총 주행거리
                SizedBox(
                    width: width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '누적주행거리',
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

                // 텍스트 필드
                SizedBox(
                  width: width,
                  child: TextField(
                    controller: odoFieldController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    onTapOutside: (event) {
                      String newOdo = odoFieldController.text;
                      _modifyOdo(newOdo, selectedCar);

                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onSubmitted: (newOdo) {
                      _modifyOdo(newOdo, selectedCar);

                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),

                // 패딩
                const SizedBox(
                  height: 19,
                ),

                // 사진 타이틀
                SizedBox(
                    width: width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '사진',
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

                // 패딩
                const SizedBox(
                  height: 19,
                ),

                Hero(
                    tag: 'maininfo',
                    child: GestureDetector(
                      child: Container(
                        width: width + 18,
                        height: 320,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/image1.png'),
                            fit: BoxFit.cover,
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
                      ),
                      onTap: () {
                        // 이미지 로드 해서 변경하는거 구현
                      },
                    )),

                // 패딩
                const SizedBox(
                  height: 19,
                ),

                //삭제 버튼
                GestureDetector(
                  child: SizedBox(
                    width: 160,
                    height: 60,
                    child: Container(
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(1.00, -0.03),
                          end: Alignment(-1, 0.03),
                          colors: [
                            Color.fromARGB(255, 255, 78, 78),
                            Color.fromARGB(255, 255, 79, 79)
                          ],
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
                            '차량삭제',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);

                    carInfoList.delete(selectedCar.id);
                    final keysToDelete = fuelInfoList.values.where(
                        (element) => element.carId.contains(selectedCar.id));

                    for (var element in keysToDelete) {
                      debugPrint(element.carId);
                      await fuelInfoList.delete(element.id);
                    }

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomeScreen(
                        title: 'title',
                      );
                    }));
                  },
                )
              ],
            ),
          ))),
    );
  }
}
