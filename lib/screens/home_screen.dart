import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:simple_bikelog/model/car_info_model.dart';
import 'package:simple_bikelog/screens/add_fuel_history_screen.dart';
import 'package:simple_bikelog/screens/add_new_car_screen.dart';
import 'package:simple_bikelog/screens/fuel_history_screen.dart';
import 'package:simple_bikelog/screens/info_screen.dart';
import 'package:simple_bikelog/constants/bikelog_colors.dart';
import 'package:simple_bikelog/screens/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final CarInfo? info;

  const HomeScreen({
    super.key,
    required this.title,
    this.info,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var carInfoList = Hive.box<CarInfo>('carInfo');

  Iterable<CarInfo> _searchedCarInfo = [];

  late CarInfo selectedCar;

  @override
  void initState() {
    super.initState();
    _searchedCarInfo = carInfoList.values;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 38;

    if (_searchedCarInfo.isEmpty) {
      return const AddNewCarScreen(title: '차량 추가');

      // 앱을 처음 깔면 info가 없기 때문에 여기로 빠짐
    }

    selectedCar = widget.info ?? _searchedCarInfo.first;

    debugPrint(widget.info?.carName);

    return Scaffold(
      backgroundColor: BikeLogColors.background,
      drawer: const DrawerScreen(),

      // appbar
      appBar: AppBar(
        backgroundColor: BikeLogColors.appbar,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
        shadowColor: Colors.black,
        title: const Text(
          '목록',
          style: TextStyle(
            color: BikeLogColors.grey,
            fontSize: 19,
            fontWeight: FontWeight.w400,
          ),
        ),
        iconTheme: const IconThemeData(color: BikeLogColors.grey),
      ),

      // body
      body: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 19,
                ),

                //main info widget
                GestureDetector(
                  child: Hero(
                    tag: 'maininfo',
                    child: Container(
                      width: width,
                      height: 320,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/image1.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
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
                          // 이미지 위 tint 오버레이
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: width,
                              height: 320,
                              decoration: ShapeDecoration(
                                color: Colors.black
                                    .withOpacity(0.4300000071525574),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            ),
                          ),

                          // 차량 명
                          Positioned(
                            left: 25,
                            top: 19,
                            child: Text(
                              selectedCar.carName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -1.60,
                              ),
                            ),
                          ),

                          // 평균 연비 text
                          const Positioned(
                            left: 25,
                            top: 136,
                            child: Text(
                              '평균 연비',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                                height: 0,
                                letterSpacing: -0.75,
                              ),
                            ),
                          ),

                          // 평균 연비 value
                          Positioned(
                              left: 22,
                              top: 150,
                              child: Row(
                                children: [
                                  Text(
                                    selectedCar.mpg.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 48,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      height: 0,
                                      letterSpacing: -2.40,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  const Text(
                                    'km/L',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      height: 0,
                                      letterSpacing: -1.20,
                                    ),
                                  ),
                                ],
                              )),

                          // 누적 주행 거리 text
                          const Positioned(
                            left: 25,
                            top: 228,
                            child: Text(
                              '누적주행거리',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                                height: 0,
                                letterSpacing: -0.75,
                              ),
                            ),
                          ),

                          // 누적 주행 거리 value
                          Positioned(
                              left: 22,
                              top: 242,
                              child: Row(
                                children: [
                                  Text(
                                    selectedCar.odo.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 48,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      height: 0,
                                      letterSpacing: -2.40,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  const Text(
                                    'km',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      height: 0,
                                      letterSpacing: -1.20,
                                    ),
                                  ),
                                ],
                              )),

                          // 상세히 보기 아이콘
                          const Positioned(
                            left: 320,
                            top: 141,
                            child: SizedBox(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 38,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    debugPrint('Move to info');

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return InfoScreen(
                        title: "정보 수정",
                        selectedCar: selectedCar,
                      );
                    }));
                  },
                ),

                const SizedBox(
                  height: 19,
                ),

                // 기록 보기
                GestureDetector(
                  child: Hero(
                    tag: 'history',
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
                      child: const Stack(
                        children: [
                          Positioned(
                            left: 42,
                            top: 12,
                            child: Text(
                              '주유 기록',
                              style: TextStyle(
                                color: BikeLogColors.grey,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.80,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 13,
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: SizedBox(
                                      child: Icon(
                                        Icons.article,
                                        color: BikeLogColors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FuelHistoryScreen(
                        selectedCar: selectedCar,
                      );
                    }));
                  },
                ),

                const SizedBox(
                  height: 19,
                ),

                // 남은 거리
                GestureDetector(
                  child: Container(
                    width: width,
                    height: 122,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(1.00, -0.03),
                        end: Alignment(-1, 0.03),
                        colors: [Color(0xFFF6F6F6), Color(0xFFFAFAFA)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
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
                        // 주행가능거리 text
                        const Positioned(
                          left: 19,
                          top: 24,
                          child: Text(
                            '예상 주행가능거리',
                            style: TextStyle(
                              color: BikeLogColors.grey,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.80,
                            ),
                          ),
                        ),

                        // 주행가능거리 value
                        Positioned(
                          left: 19,
                          top: 50,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: (selectedCar.lastFuel * selectedCar.mpg)
                                      .toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: -2,
                                  ),
                                ),
                                const TextSpan(
                                  text: '  km',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 32,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                    letterSpacing: -1.60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 주유기록추가 text
                        const Positioned(
                          right: 40,
                          top: 65,
                          child: Text(
                            '주유기록추가',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: BikeLogColors.light_grey,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.80,
                            ),
                          ),
                        ),

                        // 주유기록추가 아이콘
                        const Positioned(
                          right: 15,
                          top: 69,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: BikeLogColors.light_grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddNewFuelHistoryScreen(selectedCar: selectedCar);
                    }));
                  },
                ),

                //
                const SizedBox(
                  height: 19,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
