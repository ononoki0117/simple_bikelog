import 'package:flutter/material.dart';
import 'package:simple_bikelog/constants/bikelog_colors.dart';
import 'package:simple_bikelog/model/car_info_model.dart';
import 'package:simple_bikelog/screens/home_screen.dart';

class DrawerMenuItem extends StatelessWidget {
  final CarInfo info;
  const DrawerMenuItem({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 3 * 2;

    return GestureDetector(
      onTap: () {
        debugPrint("Move to ${info.carName} Screen");

        if (Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).closeDrawer();
        }

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen(
            title: 'title',
            info: info,
          );
        }));
        // todo : 페이지 이동 구현
      },
      child: Container(
        width: width,
        height: 80,
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
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: width,
                height: 80,
                decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.4300000071525574),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 13,
              top: 24,
              child: Text(
                info.carName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Positioned(
                right: 13,
                top: 26,
                child: Icon(Icons.arrow_forward_ios,
                    color: Colors.white, size: 20))
          ],
        ),
      ),
    );
  }
}
